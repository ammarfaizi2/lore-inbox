Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVKMWYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVKMWYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 17:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVKMWYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 17:24:54 -0500
Received: from mailfe07.tele2.fr ([212.247.154.204]:54151 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750765AbVKMWYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 17:24:53 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sun, 13 Nov 2005 23:24:21 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: 7eggert@gmx.de
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Message-ID: <20051113222421.GJ4972@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	7eggert@gmx.de, "Antonino A. Daplas" <adaplas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <58c2Z-8jG-23@gated-at.bofh.it> <E1EbNir-0006ky-DP@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1EbNir-0006ky-DP@be1.lrz>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert, le Sun 13 Nov 2005 20:41:04 +0100, a écrit :
> 2) If the videomode is 7, the card is asumed not to be a VGA card.
> VGA does support videomode 7, so this test is wrong.

But IIRC, in that case, the VGA board just emulates a MDA adapter, so
using it as an MDA adapter makes sense.

Regards,
Samuel
