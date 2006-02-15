Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWBOVhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWBOVhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWBOVhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:37:09 -0500
Received: from xenotime.net ([66.160.160.81]:5307 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751300AbWBOVhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:37:07 -0500
Date: Wed, 15 Feb 2006 13:37:05 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: linux-kernel@vger.kernel.org
cc: bjorn.helgaas@hp.com, akpm@osdl.org
Subject: Re: + mmconfig-add-kernel-parameter-documentation.patch added to
 -mm tree
In-Reply-To: <200602152101.k1FL1flj013177@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0602151334390.32155@shark.he.net>
References: <200602152101.k1FL1flj013177@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006 akpm@osdl.org wrote:

>
> The patch titled
>
>      mmconfig: add kernel parameter documentation
>
> has been added to the -mm tree.  Its filename is
>
>      mmconfig-add-kernel-parameter-documentation.patch
>
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
>
>
> From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
> Mention the "pci=nommconf" option in kernel-parameters.txt.
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  Documentation/kernel-parameters.txt |    2 ++
>  1 files changed, 2 insertions(+)
>
> diff -puN Documentation/kernel-parameters.txt~mmconfig-add-kernel-parameter-documentation Documentation/kernel-parameters.txt
> --- devel/Documentation/kernel-parameters.txt~mmconfig-add-kernel-parameter-documentation	2006-02-15 13:00:34.000000000 -0800
> +++ devel-akpm/Documentation/kernel-parameters.txt	2006-02-15 13:00:34.000000000 -0800
> @@ -1150,6 +1150,8 @@ running once the system is up.
>  				Mechanism 1.
>  		conf2		[IA-32] Force use of PCI Configuration
>  				Mechanism 2.
> +		nommconf	[IA-32] Disable use of MMCONFIG for PCI
> +				Configuration

should be (add X86-64):
		nommconf	[IA-32,X86-64] Disable use of MMCONFIG
				for PCI Configuration

>  		nosort		[IA-32] Don't sort PCI devices according to
>  				order given by the PCI BIOS. This sorting is
>  				done to get a device order compatible with

-- 
~Randy
