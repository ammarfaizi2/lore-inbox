Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130177AbRAJAUY>; Tue, 9 Jan 2001 19:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130508AbRAJAUF>; Tue, 9 Jan 2001 19:20:05 -0500
Received: from jalon.able.es ([212.97.163.2]:41887 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130191AbRAJATr>;
	Tue, 9 Jan 2001 19:19:47 -0500
Date: Wed, 10 Jan 2001 01:19:38 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0-ac4
Message-ID: <20010110011938.A2997@werewolf.able.es>
In-Reply-To: <E14FS17-0003lC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14FS17-0003lC-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 08, 2001 at 03:26:34 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling kernel/ksyms.c:

ksyms.c:209: warning: type defaults to `int' in declaration of `EXPORT_SYKBOL'
ksyms.c:209: warning: parameter names (without types) in function declaration
ksyms.c:209: warning: data definition has no type or storage class

patch-2.4.0-ac4.gz, line 195029:

 EXPORT_SYMBOL(generic_buffer_fdatasync);
+EXPORT_SYKBOL(generic_open_file);

Happy typo....

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac4 #1 SMP Mon Jan 8 22:10:06 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
