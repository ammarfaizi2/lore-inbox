Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWAYSQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWAYSQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWAYSQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:16:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52996 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932086AbWAYSQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:16:29 -0500
Date: Wed, 25 Jan 2006 19:17:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060125181736.GX4212@suse.de>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B075.6000602@gmx.de> <43D7B2DF.nailDFJA51SL1@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D7B2DF.nailDFJA51SL1@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25 2006, Joerg Schilling wrote:
> > So I'll repeat my question: is there anything that SG_IO to /dev/hd* (via
> > ide-cd) cannot do that it can do via /dev/sg*? Device enumeration doesn't count.
> 
> But device enumeration is the central point when implementing
> -scanbus.

And that's why I state it's useless on Linux.

> Note that all OS that I am aware of internally use a device
> enumeration scheme that is close to what libscg uses. This ie even
> true for Linux. If Linux did not hide this information for /dev/hd*
> based fd's, I could implement an abstraction layer.....

Not true, Linux has nothing of the sort internally for eg ATAPI devices.
I don't know why you think that, but it's simply not true at all.

-- 
Jens Axboe

