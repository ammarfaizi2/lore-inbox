Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWAYTEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWAYTEX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWAYTEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:04:23 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:53516 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750759AbWAYTEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:04:22 -0500
Date: Wed, 25 Jan 2006 20:04:21 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060125190421.GA97803@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125173127.GR4212@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 06:31:27PM +0100, Jens Axboe wrote:
> In fact it would be a _lot_ easier to just scan sysfs and do an inquiry
> on potentially useful devices.

Serious question, what and how?  If I scan /sys/block for example for
potential candidates, that won't give me the devices or tell me the
name udev decided to use for it in /dev.

And I'm not sure how to know if something is cdrom-ish and SG_IO able
from sysfs.  Should I filter on driver name?  But then, I don't know
which names are acceptable (*cdrom* ?)...

Or maybe I should go through the fad-of-the-day, hal/dbus?

  OG.
