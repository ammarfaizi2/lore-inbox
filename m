Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVGEMDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVGEMDx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 08:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVGEMDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 08:03:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49611 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261803AbVGEMDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 08:03:51 -0400
Subject: Re: Memory leak with 2.6.12 and cdrecord
From: Jens Axboe <axboe@suse.de>
To: Patrick Plattes <patrick@erdbeere.net>
Cc: linux-kernel@vger.kernel.org,
       Aleksander Pavic <aleksander.pavic@t-online.de>
In-Reply-To: <20050705113343.GA6349@erdbeere.net>
References: <20050705113343.GA6349@erdbeere.net>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 14:06:45 +0200
Message-Id: <1120565206.12942.3.camel@linux>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-05 at 13:33 +0200, Patrick Plattes wrote:
> Hi Ho :-),
> 
> we have some trouble with the 2.6v kernel tree and CDRecord 2.01 (Debian
> Sarge package). If we try to write an 150MB CD the memory fills up to
> 150MB. The memory will not deallocate after closing cdrecord. Next if we
> try to write an 200MB CD the memory will filled up to additional 50MB.
> 
> We don't know which part of the software is steals our memory. This only
> happens on 2.6, not on an 2.4 system and we can reproduce the bug only
> on the asus notebook.
> 
> We have tried to find the leak with top and slabtop, but inconclusively. I 
> put some information together. The informations are taken from the system 
> after burning a 154MB CD. Please have a look at: http://cdrecord.sourcecode.cc . 
> I uploaded the files to this address, to avoid high traffic on the lkml.

Please post /proc/slabinfo as well.

-- 
Jens Axboe <axboe@suse.de>

