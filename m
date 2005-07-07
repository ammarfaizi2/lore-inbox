Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVGGPXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVGGPXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVGGPF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:05:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62430 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261502AbVGGPFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:05:38 -0400
Date: Thu, 7 Jul 2005 17:05:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Shawn Starr <spstarr@sh0n.net>
Cc: hdaps-devel@lists.sourceforge.net, Lenz Grimmer <lenz@grimmer.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050707150548.GD24401@suse.de>
References: <42C8D06C.2020608@grimmer.com> <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de> <200507071028.06765.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507071028.06765.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07 2005, Shawn Starr wrote:
> 
> Model: HTS548080M9AT00 (Hitachi)
> Laptop: T42.
> 
> segfault:/home/spstarr# ./a /dev/hda
> head parked
> 
> Seems to park, heard it click :)

Note on that - if the util says it parked, you can be very sure that it
actually did as the drive actually returns that status outside of just
completing the command.

Just FYI for the people that are going to work on the surrounding
support.

-- 
Jens Axboe

