Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756125AbWKRBsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125AbWKRBsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 20:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756126AbWKRBsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 20:48:25 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:19431 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1756125AbWKRBsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 20:48:25 -0500
Date: Fri, 17 Nov 2006 20:47:53 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: Re: [PATCH 19/20] x86_64: Extend bzImage protocol for relocatable kernel
Message-ID: <20061118014753.GB25205@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com> <20061117225826.GT15449@in.ibm.com> <455E540C.6090202@zytor.com> <20061118003718.GB4321@in.ibm.com> <455E57BA.7060309@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455E57BA.7060309@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 04:45:46PM -0800, H. Peter Anvin wrote:
> Vivek Goyal wrote:
> >On Fri, Nov 17, 2006 at 04:30:04PM -0800, H. Peter Anvin wrote:
> >>Vivek Goyal wrote:
> >>>o Extend the bzImage protocol (same as i386) to allow bzImage loaders to
> >>> load the protected mode kernel at non-1MB address. Now protected mode
> >>> component is relocatable and can be loaded at non-1MB addresses.
> >>>
> >>>o As of today kdump uses it to run a second kernel from a reserved memory
> >>> area.
> >>>
> >>>Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> >>Do you have a patch for Documentation/i386/boot.txt as well?
> >>
> >
> >Yes. As documentation is shared between i386 and x86_64, It is already 
> >there
> >in Andi's tree and in -mm. I had pushed that with i386 relocatable bzImage
> >changes.
> >
> >http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/broken-out/x86_64-mm-extend-bzimage-protocol-for-relocatable-protected-mode-kernel.patch
> >
> 
> Your documentation change is buggy.
> 
> The fields at 0230/4 and 0234/1 are 2.05+ not 2.04+
> 
> Please fix, also please update the last revision date.

Thanks for noticing this. Just now sent a patch in separate thread to fix
this.

Thanks
Vivek
