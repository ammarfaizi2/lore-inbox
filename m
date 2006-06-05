Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932338AbWFDX7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWFDX7h (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 19:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWFDX7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 19:59:37 -0400
Received: from xenotime.net ([66.160.160.81]:41632 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932338AbWFDX7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 19:59:36 -0400
Date: Sun, 4 Jun 2006 17:02:18 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: utsname/hostname
Message-Id: <20060604170218.f45a5302.rdunlap@xenotime.net>
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 13:50:11 -0700 Andrew Morton wrote:

> 
> It's time to take a look at the -mm queue for 2.6.18.
> 
> 
> When replying to this email pleeeeeeze rewrite the Subject: to something
> appropriate so we do not all go mad.  Thanks.
> 
> 
> proc-sysctl-add-_proc_do_string-helper.patch
> namespaces-add-nsproxy.patch
> namespaces-add-nsproxy-dont-include-compileh.patch
> namespaces-incorporate-fs-namespace-into-nsproxy.patch
> namespaces-utsname-introduce-temporary-helpers.patch
> namespaces-utsname-switch-to-using-uts-namespaces.patch
> namespaces-utsname-switch-to-using-uts-namespaces-alpha-fix.patch
> namespaces-utsname-switch-to-using-uts-namespaces-cleanup.patch
> namespaces-utsname-use-init_utsname-when-appropriate.patch
> namespaces-utsname-use-init_utsname-when-appropriate-cifs-update.patch
> namespaces-utsname-implement-utsname-namespaces.patch
> namespaces-utsname-implement-utsname-namespaces-export.patch
> namespaces-utsname-implement-utsname-namespaces-dont-include-compileh.patch
> namespaces-utsname-sysctl-hack.patch
> namespaces-utsname-sysctl-hack-cleanup.patch
> namespaces-utsname-sysctl-hack-cleanup-2.patch
> namespaces-utsname-sysctl-hack-cleanup-2-fix.patch
> namespaces-utsname-remove-system_utsname.patch
> namespaces-utsname-implement-clone_newuts-flag.patch
> uts-copy-nsproxy-only-when-needed.patch
> # needed if git-klibc isn't there:
> #namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit.patch
> #namespaces-utsname-use-init_utsname-when-appropriate-klibc-bit.patch
> #namespaces-utsname-switch-to-using-uts-namespaces-klibc-bit-2.patch
> 
>  utsname virtualisation.  This doesn't seem very pointful as a standalone
>  thing.  That's a general problem with infrastructural work for a very
>  large new feature.
> 
>  So probably I'll continue to babysit these patches, unless someone can
>  identify a decent reason why mainline needs this work.

Not a strong argument for mainline, but I have a patch to make
<hostname> larger (up to 255 bytes, per POSIX).
  http://www.xenotime.net/linux/patches/hostname-2617-rc5b.patch

I can either update my hostname patch against mm/utsname.. or not.
But I don't really want to see some/any patch blocked due to a patch
in -mm being borderline "pointful," so how do we deal with this?

>  I don't want to carry an ever-growing stream of OS-virtualisation
>  groundwork patches for ever and ever so if we're going to do this thing...
>  faster, please.


---
~Randy
