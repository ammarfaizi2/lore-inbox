Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVAaRGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVAaRGq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVAaRGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:06:45 -0500
Received: from [81.2.110.250] ([81.2.110.250]:8411 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261264AbVAaRGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:06:40 -0500
Subject: Re: raid 1 - automatic 'repair' possible?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ric Wheeler <ric@emc.com>
Cc: Jakob Oestergaard <jakob@unthought.net>, Kiniger <karl.kiniger@med.ge.com>,
       Lars Marowsky-Bree <lmb@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41FA6ADE.4010209@emc.com>
References: <20050118211801.GA28400@wszip-kinigka.euro.med.ge.com>
	 <20050118214605.GY22648@marowsky-bree.de>
	 <20050119104852.GB3087@wszip-kinigka.euro.med.ge.com>
	 <20050119115519.GY347@unthought.net>  <41FA6ADE.4010209@emc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107171389.14787.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 31 Jan 2005 16:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Depending on the type of drive error, the act of writing is likely to 
> clean the questionable sector and leave you with a perfectly fine disk.
> 

Definitely - and in fact some of the other Linux tools already know
about this and do it (for example ext3 fsck will force rewrite bad
blocks if you want).

