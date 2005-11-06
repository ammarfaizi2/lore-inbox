Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVKFAo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVKFAo5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVKFAo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:44:57 -0500
Received: from mailfe07.tele2.fr ([212.247.154.204]:53945 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932248AbVKFAo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:44:57 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sun, 6 Nov 2005 01:44:51 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       mlang@debian.org
Subject: Re: [PATCH] Set the vga cursor even when hidden
Message-ID: <20051106004451.GF8183@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	"Antonino A. Daplas" <adaplas@gmail.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
	mlang@debian.org
References: <20051105211949.GM7383@bouh.residence.ens-lyon.fr> <436D5047.4080006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <436D5047.4080006@gmail.com>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Antonino A. Daplas, le Sun 06 Nov 2005 08:37:27 +0800, a écrit :
> Why not use this method (scanline_end < scanline_start) for VGA, and
> the default method (moving the cursor out of the screen) for the rest?

Well, visually impaired people might want to use other cards as well.

> Or why not just set bit 5 of the cursor start register (port 0x0a) to disable
> the cursor, and clear to enable? I believe this will also work for the
> other types.

If this works, it would be fine.

Regards,
Samuel
