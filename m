Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWDYKdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWDYKdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWDYKdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:33:36 -0400
Received: from verein.lst.de ([213.95.11.210]:27355 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750831AbWDYKdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:33:35 -0400
Date: Tue, 25 Apr 2006 12:33:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Leubner, Achim" <Achim_Leubner@adaptec.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: HEADS UP for gdth driver users
Message-ID: <20060425103329.GA29390@lst.de>
References: <EF6AF37986D67948AD48624A3E5D93AFAA92DF@mtce2k01.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EF6AF37986D67948AD48624A3E5D93AFAA92DF@mtce2k01.adaptec.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 02:21:00PM +0200, Leubner, Achim wrote:
> Is there any news on that? Can we use the scsi_get/put_command() functions for allocating a "struct scsi_cmnd" or should we allocate it with kmalloc() or somehow like that? Or, Christoph, did you already make the second patch for the gdth driver? 
> We want to bring the gdth driver up to date as soon as possible. Any help is greatly appreciated! 
Sorry, I didn't have time to look at this yet.  scsi_get/put_command()
sems ok for now, if you have time to look at this now it would be good
if you could look at it.  It's too late for 2.6.17 already, but having
it early in the 2.6.18 cycle would be very helpful.

