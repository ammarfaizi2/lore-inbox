Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbTJIORu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbTJIORu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:17:50 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:4794 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262059AbTJIORt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:17:49 -0400
Date: Thu, 9 Oct 2003 15:17:36 +0100
From: Dave Jones <davej@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode
Message-ID: <20031009141734.GB23545@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jens Axboe <axboe@suse.de>,
	Jeff Garzik <jgarzik@pobox.com>, marcelo.tosatti@cyclades.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200310091103.h99B31ug014566@hera.kernel.org> <3F856A7E.2010607@pobox.com> <20031009140547.GD1232@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009140547.GD1232@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 04:05:47PM +0200, Jens Axboe wrote:

 > > Red Hat just dropped this patch since it was suspected of data 
 > > corruption ;-(
 > Eh? Care to explain a bit further? I'm not aware of any data corruption
 > issues there, and it's certainly simple enough to easily audit.

3-4 cases of random data corruption, all using Quantum Fireball drives,
all with different IDE chipsets.

 > And how kind of Red Hat to not inform me of any suspicion in this
 > regard.

I want to get facts right before crying wolf.
Right now laptopmode/aam is just a suspect. There are still 1-2 other
small patches against IDE which could be the reason.  We've dropped
laptopmode/aam for the time being to see if the folks seeing repeatable
corruption suddenly start behaving again.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
