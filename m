Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKPWam>; Thu, 16 Nov 2000 17:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbQKPWab>; Thu, 16 Nov 2000 17:30:31 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:61962 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129183AbQKPWaX>;
	Thu, 16 Nov 2000 17:30:23 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Local root exploit with kmod and modutils > 2.1.121 
In-Reply-To: Your message of "Thu, 16 Nov 2000 22:21:52 BST."
             <20001116222152.E8326@nomade> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Nov 2000 09:00:16 +1100
Message-ID: <5529.974412016@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000 22:21:52 +0100, 
Xavier Bestel <xavier.bestel@free.fr> wrote:
>as modprobe (insmod) args parsing seems POSIX compliant, we should put a
>"--" before
>what should be interpreted only as a textual argument, not as an option.
>This is a lot safer: whatever is passed, modprobe will take it as a module
>name.

That only solves one of the two exploit methods.  modutils 2.3.20
solves both without any kernel changes, mainly so it fixes the problem
on all kernels, including 2.2.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
