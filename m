Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbQLAXaE>; Fri, 1 Dec 2000 18:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129891AbQLAX3z>; Fri, 1 Dec 2000 18:29:55 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:34830 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129825AbQLAX3m>;
	Fri, 1 Dec 2000 18:29:42 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: John Levon <moz@compsoc.man.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre24 and drm/agpgart static? 
In-Reply-To: Your message of "Fri, 01 Dec 2000 14:52:11 -0000."
             <Pine.LNX.4.21.0012011450270.1317-100000@mrworry.compsoc.man.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 02 Dec 2000 09:59:08 +1100
Message-ID: <21249.975711548@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2000 14:52:11 +0000 (GMT), 
John Levon <moz@compsoc.man.ac.uk> wrote:
>Probably you have modversions enabled (CONFIG_MODVERSION=y). Disable that
>and try again, or build as modules. 2.4 fixed this problem in the proper
>way, but I don't know what's going to happen about 2.2 ...

I have sent a backport of inter_module_xxx to Alan Cox, he has not
included it in 2.2 kernels yet, maybe 2.2.19.  When inter_module_xxx is
available in 2.2, the DRM/AGP change can be backported as well.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
