Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbUJ0EVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbUJ0EVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbUJ0EVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:21:15 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:32534 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261485AbUJ0EVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:21:10 -0400
Date: Wed, 27 Oct 2004 08:21:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Airlie <airlied@gmail.com>
Cc: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>,
       Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for initramfs image updates [u]
Message-ID: <20041027062148.GA12123@mars.ravnborg.org>
Mail-Followup-To: Dave Airlie <airlied@gmail.com>,
	"Martin Schlemmer [c]" <azarah@nosferatu.za.org>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	torvalds@osdl.org,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <200410200849.i9K8n5921516@mail.osdl.org> <1098533188.668.9.camel@nosferatu.lan> <20041026221216.GA30918@mars.ravnborg.org> <1098824849.12420.60.camel@nosferatu.lan> <20041026231514.GA3285@mars.ravnborg.org> <21d7e997041026210935b2954a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e997041026210935b2954a@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 02:09:34PM +1000, Dave Airlie wrote:
 > If timestamp differ then initramfs_list will be updated and initramfs
> > image will be remade.
> 
> please put the timestamps somewhere that don't end up in the final kernel....

initramfs_list is only an inputfile to gen_cpio. So comments in this
file will/should not end up in final image.

> My life involves reproducing complete FLASH systems at any point in
> time exactly the same as the ones I produced at the previous point in
> time, I've had to hack about 5 or 6 things in the kernel to do this,

Could you try to list the places - maybe they do not all make sense.

	Sam
