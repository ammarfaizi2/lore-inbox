Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbVKXLXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbVKXLXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 06:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbVKXLXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 06:23:43 -0500
Received: from hera.cwi.nl ([192.16.191.8]:50627 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1161032AbVKXLXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 06:23:43 -0500
Date: Thu, 24 Nov 2005 12:23:31 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Phil Dibowitz <phil@ipom.com>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Alan Stern <stern@rowland.harvard.edu>,
       usb-storage@lists.one-eyed-alien.net, Bob Copeland <me@bobcopeland.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [usb-storage] Re: [PATCH] usb-storage: Add support for Rio Karma
Message-ID: <20051124112331.GA3891@apps.cwi.nl>
References: <20051123113342.GA5815@hash.localnet> <Pine.LNX.4.44L0.0511231316410.12957-100000@iolanthe.rowland.org> <20051123183924.GA1016@apps.cwi.nl> <43853CC0.10203@ipom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43853CC0.10203@ipom.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 08:08:32PM -0800, Phil Dibowitz wrote:

> > UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xffff,
> >                 "Feiya",
> >                 "5-in-1 Card Reader",
> >                 US_SC_DEVICE, US_PR_DEVICE, NULL,
> >                 US_FL_FIX_CAPACITY ),
> 
> Can you be more specific? Matthew added some code (specifically a delay)
> which should have taken care of most if not all of these a few kernel
> versions ago (.12-ish?)...

I don't understand how adding a delay can influence the fact that
it returns the wrong capacity.
