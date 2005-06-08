Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVFHLIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVFHLIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVFHLIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:08:39 -0400
Received: from mail1.kontent.de ([81.88.34.36]:26248 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262168AbVFHLId convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:08:33 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Wakko Warner <wakko@animx.eu.org>
Subject: Re: kaweth fails to work on 2.6.12-rc[56]
Date: Wed, 8 Jun 2005 13:08:39 +0200
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050608021140.GA28524@animx.eu.org> <200506080859.27857.oliver@neukum.org> <20050608104217.GA29490@animx.eu.org>
In-Reply-To: <20050608104217.GA29490@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506081308.39450.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 8. Juni 2005 12:42 schrieb Wakko Warner:
> > have you tried recompiling with debug enabled?
> > It does show the status codes in the interrupt handler.
> 
> I have not.  My keyboard and mouse (on a hub) are plugged in beside the
> kaweth device so they would be on the same interrupt.

Sorry, I should be more specific. It will print out the error codes
internal to the USB layer which are meaningful even if interrupts are shared.
Also, are you seeing tx errors in the error count?

	Regards
		Oliver
