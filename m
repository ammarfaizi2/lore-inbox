Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVKMWZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVKMWZj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 17:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVKMWZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 17:25:38 -0500
Received: from mailfe04.tele2.fr ([212.247.154.108]:9928 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750769AbVKMWZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 17:25:37 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sun, 13 Nov 2005 23:25:14 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Message-ID: <20051113222514.GK4972@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	"Antonino A. Daplas" <adaplas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <43766AC5.9080406@gmail.com> <20051113110618.GD4117@implementation> <43774EAE.90004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43774EAE.90004@gmail.com>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas, le Sun 13 Nov 2005 22:33:18 +0800, a écrit :
> Samuel Thibault wrote:
> > Antonino A. Daplas, le Sun 13 Nov 2005 06:20:53 +0800, a écrit :
> >> "I updated to the development kernel and now during boot only the top of the
> >> text is visable. For example the monitor screen the is the lines and I can
> >> only  see text in the asterik area.
> >> ---------------------
> >> | ****************  |
> >> | *              *  |
> >> | *              *  |
> >> | ****************  |
> >> |                   |
> >> |                   |
> >> |                   |
> >> ---------------------
> > 
> > Are you missing some left and right part too? What are the dimensions of
> > the text screen at bootup? What bootloader are you using? (It could be a
> > bug in the boot up text screen dimension discovery).
> 
> It was just the height.  All numbers (done with printk's) look okay from
> bootup. He gets 80 and 25 for ORIG_VIDEO_NUM_COLS and ORIG_VIDEO_NUM_LINES
> respectively.

And you got less than 25 lines? How many exactly?

Regards,
Samuel
