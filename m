Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267280AbTAGC1A>; Mon, 6 Jan 2003 21:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267277AbTAGC1A>; Mon, 6 Jan 2003 21:27:00 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:40095 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S267276AbTAGC06>;
	Mon, 6 Jan 2003 21:26:58 -0500
Date: Mon, 6 Jan 2003 19:15:22 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-kernel@one-eyed-alien.net,
       zwane@holomorphy.com
Subject: Re: IDs
Message-ID: <20030106191522.A11624@beaverton.ibm.com>
References: <UTC200301070219.h072JjD19965.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200301070219.h072JjD19965.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Tue, Jan 07, 2003 at 03:19:45AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 03:19:45AM +0100, Andries.Brouwer@cwi.nl wrote:
> > We can tell if the id sdev->name should be unique by looking at
> > the first byte (it is not unique if the value is 'Z'),
> > SCSI_UID_UNKNOWN.
> 
> Such things are nontrivial.

Yes ...

> And where we have heuristics only, it cannot be "wrong"
> to truncate at 50 positions or so. The heuristic does
> not become appreciably weaker.

But, we don't have to truncate, we should just allocate as many bytes as
we need, and store the information.

And, the sysfs name should not store the id.

-- Patrick Mansfield
