Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTLSQfu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 11:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTLSQfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 11:35:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1734 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263468AbTLSQft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 11:35:49 -0500
Date: Fri, 19 Dec 2003 17:35:47 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: jaharkes@cs.cmu.edu
Subject: Re: Mount Rainier in 2.6
Message-ID: <20031219163547.GE2069@suse.de>
References: <3FE16489.9060006@tiscali.cz> <20031218083530.GP2495@suse.de> <20031218114000.GB2069@suse.de> <3FE200CA.2080705@tiscali.cz> <20031218193414.GJ2069@suse.de> <20031218225236.GA27102@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218225236.GA27102@delft.aura.cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18 2003, Jan Harkes wrote:
> On Thu, Dec 18, 2003 at 08:34:14PM +0100, Jens Axboe wrote:
> > On Thu, Dec 18 2003, Milos Prudek wrote:
> > Rats, I forgot to test sr. You probably don't have a SCSI mt rainier
> > drive (I doubt one was ever made), so just disable SCSI CD-ROM support.
> 
> Actually, external USB enclosures show up as SCSI even when they
> internally have a regular IDE/ATAPI drive. Your original patches (early
> 2.5?) did work nicely with an external USB2.0 writer.

Oh you are right - the incremental patch should fix sr, so it ought to
work.

-- 
Jens Axboe

