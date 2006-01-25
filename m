Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWAYRf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWAYRf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWAYRf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:35:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47962 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932081AbWAYRfZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:35:25 -0500
Date: Wed, 25 Jan 2006 18:31:27 +0100
From: Jens Axboe <axboe@suse.de>
To: grundig@teleline.es
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, jengelh@linux01.gwdg.de,
       rlrevell@joe-job.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060125173127.GR4212@suse.de>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20060125181847.b8ca4ceb.grundig@teleline.es>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25 2006, grundig@teleline.es wrote:
> El Wed, 25 Jan 2006 18:03:18 +0100,
> Joerg Schilling <schilling@fokus.fraunhofer.de> escribió:
> 
> > Guess why cdrecord -scanbus is needed.
> > 
> > It serves the need of GUI programs for cdrercord and allows them to retrieve 
> > and list possible drives of interest in a platform independent way.
> 
> But this is not neccesary at all, since linux platform already
> provides ways to retrieve and list possible drives....

In fact it would be a _lot_ easier to just scan sysfs and do an inquiry
on potentially useful devices.

-- 
Jens Axboe

