Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130230AbRA1VZF>; Sun, 28 Jan 2001 16:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbRA1VY4>; Sun, 28 Jan 2001 16:24:56 -0500
Received: from [216.233.172.106] ([216.233.172.106]:6660 "EHLO
	foozle.axistangent.net") by vger.kernel.org with ESMTP
	id <S130230AbRA1VYf>; Sun, 28 Jan 2001 16:24:35 -0500
Date: Sun, 28 Jan 2001 15:21:56 -0600
From: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
To: David Ford <david@linux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc update/fixes for sysrq.txt
Message-ID: <20010128152156.A406@foozle.turbogeek.org>
In-Reply-To: <20010128051118.A7975@foozle.turbogeek.org> <3A740416.55E93274@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A740416.55E93274@linux.com>; from david@linux.com on Sun, Jan 28, 2001 at 11:35:50AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001 11:35:50 +0000, David Ford wrote:
> AFAIK, this hasn't ever been true.  I have never had to specifically
> enable it at run time.

I was suspicious of that in the old doc but thought I'd leave it in...
Should have asked for feedback on it, but you caught it anyway, thanks!

Here's a patch against the first that simply removes the lines.

/jmd


--- Documentation/sysrq.txt~    Sun Jan 28 14:41:44 2001
+++ Documentation/sysrq.txt     Sun Jan 28 14:41:52 2001
@@ -15,9 +15,6 @@
 
         echo "0" > /proc/sys/kernel/sysrq
 
-Note that previous versions disabled sysrq by default, and you were required
-to specifically enable it at run-time. That is not the case any longer.
-
 *  How do I use the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 On x86   - You press the key combo 'ALT-SysRq-<command key>'. Note - Some
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
