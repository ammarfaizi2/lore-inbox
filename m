Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUKORcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUKORcw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 12:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbUKORcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 12:32:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49834 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261340AbUKORcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 12:32:50 -0500
Date: Mon, 15 Nov 2004 12:32:45 -0500
From: "John W. Linville" <linville@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "O.Sezer" <sezeroz@ttnet.net.tr>, linux-kernel@vger.kernel.org
Subject: Re: [netdrvr] netdev-2.4 queue updated
Message-ID: <20041115173245.GI14381@redhat.com>
References: <4198C64A.6050900@ttnet.net.tr> <4198E20E.5070305@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4198E20E.5070305@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 12:06:22PM -0500, Jeff Garzik wrote:
> O.Sezer wrote:
> >>John W. Linville:
> >>  o 3c59x: resync with 2.6
> >>
> >
> >Any specific reason that the following two are not included ?
> >
> >3c59x: reload EEPROM values at rmmod for needy cards:
> >http://marc.theaimsgroup.com/?l=linux-kernel&m=109726032213947&w=2
> >
> >3c59x: remove EEPROM_RESET for 3c905 :
> >http://marc.theaimsgroup.com/?l=linux-kernel&m=109802672909516&w=2
> 
> Ask John Linville...  IIRC they caused problems?

Actually, the second one was there to correct the first one.
(Only PART of the first patch was undone by the second one.)

They are additive, so they should be applied in the order above.
If you'd prefer, I could gen-up a single patch?

Thanks,

John
-- 
John W. Linville
linville@redhat.com
