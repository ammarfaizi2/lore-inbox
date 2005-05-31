Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVEaLpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVEaLpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 07:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVEaLpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 07:45:16 -0400
Received: from mail1.kontent.de ([81.88.34.36]:13275 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261309AbVEaLpN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 07:45:13 -0400
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [BUG] oops while completing async USB via usbdevio
Date: Tue, 31 May 2005 13:45:04 +0200
User-Agent: KMail/1.8
Cc: Harald Welte <laforge@gnumonks.org>, David Brownell <david-b@pacbell.net>,
       linux-kernel@vger.kernel.org
References: <20050530194443.GA22760@sunbeam.de.gnumonks.org> <200505301555.39985.david-b@pacbell.net> <20050531084852.GJ25536@sunbeam.de.gnumonks.org>
In-Reply-To: <20050531084852.GJ25536@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505311345.04999.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 31. Mai 2005 10:48 schrieb Harald Welte:
> Wouldn't it help to associate the URB with the file (instaed of the
> task), and then send the signal to any task that still has opened the
> file?  I'm willing to hack up a patch, if this is considered a sane fix.

That would seem better.

	Regards
		Oliver
