Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVFHG7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVFHG7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 02:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVFHG7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 02:59:30 -0400
Received: from mail1.kontent.de ([81.88.34.36]:45973 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262122AbVFHG71 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 02:59:27 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Wakko Warner <wakko@animx.eu.org>, linux-usb-devel@lists.sourceforge.net
Subject: Re: kaweth fails to work on 2.6.12-rc[56]
Date: Wed, 8 Jun 2005 08:59:27 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20050608021140.GA28524@animx.eu.org> <20050608031101.GA28735@animx.eu.org>
In-Reply-To: <20050608031101.GA28735@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506080859.27857.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 8. Juni 2005 05:11 schrieb Wakko Warner:
> Wakko Warner wrote:
> > Seems that it is unable to send packets however I can see packets coming in.
> > I downgraded to 2.6.12-rc2 which works.
> > 
> > I have not tested rc3 or rc4 yet.  I am preparing to try rc4.
> 
> Just finished testing.
> rc2 works
> rc3 works (fails on aic7xxx with my scsi hardware but rc5 works with my
>         scsi hardware)
> rc4 through rc6 do not work.

Hi,

have you tried recompiling with debug enabled?
It does show the status codes in the interrupt handler.

	Regards
		Oliver
