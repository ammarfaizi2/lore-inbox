Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269688AbUICRhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269688AbUICRhW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269486AbUICRaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:30:11 -0400
Received: from verein.lst.de ([213.95.11.210]:61629 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269599AbUICRYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:24:24 -0400
Date: Fri, 3 Sep 2004 19:24:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: neilb@cse.unsw.edu.au, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: bug in md write barrier support?
Message-ID: <20040903172414.GA6771@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, neilb@cse.unsw.edu.au,
	axboe@suse.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

md_flush_mddev just passes on the sector relative to the raid device,
shouldn't it be translated somewhere?
