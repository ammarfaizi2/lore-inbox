Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTGOI5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 04:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTGOI5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 04:57:40 -0400
Received: from snoopy.pacific.net.au ([61.8.0.36]:36566 "EHLO
	snoopy.pacific.net.au") by vger.kernel.org with ESMTP
	id S262593AbTGOI5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 04:57:40 -0400
Date: Tue, 15 Jul 2003 19:07:27 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: 2.6.0-t1: i2c+sensors still whacky (hi Greg :)
Message-ID: <20030715090726.GJ363@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. For a while i2c+sensors for me would freeze my box. Lately though
it has been slowing it down to a crawl. And by slow I mean I can see
the framebuffer console scroll block by block and be able to see 
individual lines half-scrolled and suchlike things. All is fine with 
the kernel until it hits the i2c and sensors code. Then it slows to
a crawl. By the look at the HD usage indicator it seems that it pauses
a second at a time (ie approx seconds pause, burst of activity, seconds
pause etc). This also happened before AS was merged into the kernel.

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://www.toledoblade.com/apps/pbcs.dll/artikkel?SearchID=73139162287496&Avis=TO&Dato=20030624&Kategori=NEWS28&Lopenr=106240111&Ref=AR
