Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129770AbQLDQ1c>; Mon, 4 Dec 2000 11:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129844AbQLDQ1N>; Mon, 4 Dec 2000 11:27:13 -0500
Received: from [202.106.187.156] ([202.106.187.156]:9741 "HELO sina.com")
	by vger.kernel.org with SMTP id <S129770AbQLDQ1M>;
	Mon, 4 Dec 2000 11:27:12 -0500
Date: Sat, 2 Dec 2000 10:20:23 +0800
From: hugang <linuxbest@sina.com>
To: linux-kernel@vger.kernel.org
Subject: Path: for oom_kill.c
In-Reply-To: <NDBBIAJKLMMHOGKNMGFNMEADCPAA.chris.swiedler@sevista.com>
In-Reply-To: <NDBBIAJKLMMHOGKNMGFNMEADCPAA.chris.swiedler@sevista.com>
X-Mailer: Sylpheed version 0.4.6 (GTK+ 1.2.8; Linux 2.4.0-test12; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20001204162712Z129770-439+868@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all:
	
old    ---->     points = p->mm->total_vm;
       
change to --->   points = p->pid;


	I write a shell to test it,

cat > bin/hello
hello
^D

hello
before change it ,kernel will kill some pid, to change it kernel will kill hello(bash).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
