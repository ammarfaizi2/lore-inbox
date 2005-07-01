Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263364AbVGAOzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbVGAOzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 10:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbVGAOzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 10:55:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21663 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263364AbVGAOzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 10:55:13 -0400
Date: Fri, 1 Jul 2005 16:56:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Luigi Genoni <genoni@darkstar.linuxpratico.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS corruption during power-blackout
Message-ID: <20050701145638.GI2243@suse.de>
References: <20050629001847.GB850@frodo> <200506290453.HAA14576@raad.intranet> <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org> <42C4FC14.7070402@slaphack.com> <20050701092412.GD2243@suse.de> <20050701131950.GA15180@ime.usp.br> <2442.192.167.206.189.1120229488.squirrel@new.host.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2442.192.167.206.189.1120229488.squirrel@new.host.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(don't top post)

On Fri, Jul 01 2005, Luigi Genoni wrote:
> problem can be that most disk become too slow to be usable if cache is
> disabled.

If you don't do queueing, then yes that is definitely true. ATA/SATA
(without ncq) is horrible with write cache off.

-- 
Jens Axboe

