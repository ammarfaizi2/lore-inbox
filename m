Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTLSJlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 04:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTLSJlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 04:41:12 -0500
Received: from head.linpro.no ([80.232.36.1]:11711 "EHLO head.linpro.no")
	by vger.kernel.org with ESMTP id S262186AbTLSJlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 04:41:08 -0500
To: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: VM-related (?) oops in 2.4.22 + rmap15k
References: <uk18ylanke9.fsf@ifconfig.linpro.no>
From: Sigurd Urdahl <sigurdur@linpro.no>
Organization: Linpro AS
Date: 19 Dec 2003 10:40:55 +0100
In-Reply-To: <uk18ylanke9.fsf@ifconfig.linpro.no>
Message-ID: <uk1zndpm9g8.fsf@ifconfig.linpro.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.9 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AXH7w-0005Bb-60*K9d/C84oHA2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sigurd Urdahl <sigurdur@linpro.no> writes:

> I believe that the kernel is also patched with ACL's and a few other
> things, but as far as I can gather none of the extra patches should
> impact on the VM. (The guy who patched together the kernel is away on
> holiday)

I have some additional info on the applied patchset. The kernel
started out as a 2.4.22 and has the following applied:

01_-_patch-2.4.22-1000-ckbase-0309132043
02_-_patch-2422-ck2base-rmap15k-0309210033
03_-_ea+acl+nfsacl-2.4.22-0.8.64.diff-rmap-compatfixes
05_-_linux-2.4.21-ipvs-1.0.10.patch
06_-_linux-2.4.20-VFS-lock.patch-fixed
07_-_linux-2.4.19-fw-tulip-mtu.patch
08_-_eepro-vlan-mtu-patch2
09_-_online-ext3-2.4.19.diff+EA+ACL-compatfixes
10_-_ebtables-brnf-2_vs_2.4.22.diff
11_-_rmapfix
12_-_patch-2.4.22-ck2-fix.patch
13_-_rmapfix_from_rik
14_-_do_brk_bounds_check

(for reference, our local maintainer is Tore Andersson)

-sig

-- 
Sigurd Urdahl                           sigurdur@linpro.no
Systemkonsulent og sånt        Systems consultant and such
Linpro A/S                           http://www.linpro.no/
