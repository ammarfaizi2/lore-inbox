Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbULHOdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbULHOdM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 09:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbULHOdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 09:33:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14535 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261230AbULHOdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 09:33:02 -0500
Date: Wed, 8 Dec 2004 14:31:47 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: device-mapper development <dm-devel@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [dm-devel] Re: 2.6: drivers/md/dm-io.c partially copies bio.c
Message-ID: <20041208143147.GG24229@agk.surrey.redhat.com>
Mail-Followup-To: device-mapper development <dm-devel@redhat.com>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
	Adrian Bunk <bunk@stusta.de>
References: <20041206120941.GB7250@stusta.de> <200412060748.51047.kevcorry@us.ibm.com> <20041206135539.GZ10498@suse.de> <200412060822.18688.kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412060822.18688.kevcorry@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 08:22:18AM -0600, Kevin Corry wrote:
> Actually, I also seem to recall discussions with Joe Thornber from quite 
> awhile ago about trying to move this bio_set functionality into fs/bio.c, 

Indeed - see his comments in dm-io.c:

/*-----------------------------------------------------------------
 * Bio set, move this to bio.c
 *---------------------------------------------------------------*/

...

/*-----------------------------------------------------------------
 * dm-io proper
 *---------------------------------------------------------------*/


Alasdair
-- 
agk@redhat.com
