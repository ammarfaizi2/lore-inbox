Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751132AbWFEOoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWFEOoH (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWFEOoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:44:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:53413 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751132AbWFEOoG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:44:06 -0400
Date: Mon, 5 Jun 2006 09:43:29 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
        Kirill Korotaev <dev@openvz.org>, Dave Hansen <haveblue@us.ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: 2.6.18 -mm merge plans
Message-ID: <20060605144328.GA12904@sergelap.austin.ibm.com>
References: <20060604135011.decdc7c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
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
> 
>  I don't want to carry an ever-growing stream of OS-virtualisation
>  groundwork patches for ever and ever so if we're going to do this thing...
>  faster, please.

Eric, Kirill, Dave, Hubertus,

In the spirit of 'faster, please', does someone care to port and
resubmit a pidspace patch?

I'll do it if noone else wants to, just don't want to step on anyone's
toes if you were already working on it.

thanks,
-serge
