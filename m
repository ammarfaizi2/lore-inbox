Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUAHMAO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 07:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUAHMAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 07:00:14 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:40858 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264366AbUAHMAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 07:00:09 -0500
Date: Thu, 8 Jan 2004 13:00:08 +0100
From: bert hubert <ahu@ds9a.nl>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: blockfile access patterns logging
Message-ID: <20040108120008.GA7415@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, axboe@suse.de,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

For some time I've wanted to log exactly what linux is reading and writing
from my harddisk - for a variety of reasons. The current reason is that my
very idle laptop writes to disk every once in a while (or reads, I don't
know).

Now, conceptually this should not be very hard, but I'd like to ask your
thoughts on where I might insert some crude logging? There are lots of
places that might be better or worse for some reason.

I'd love to be as close to the physical block device as possible, short of
rewriting actual IDE drivers.

Any tips? Or is this idea crazy?

Thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
