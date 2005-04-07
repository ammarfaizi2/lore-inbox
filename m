Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVDGGg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVDGGg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 02:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVDGGg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 02:36:58 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:41878 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261419AbVDGGg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 02:36:57 -0400
Date: Thu, 7 Apr 2005 08:36:56 +0200
From: bert hubert <ahu@ds9a.nl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050407063656.GA19069@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050406193911.GA11659@stingr.stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050406193911.GA11659@stingr.stingr.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 11:39:11PM +0400, Paul P Komkoff Jr wrote:

> Monotone is good, but I don't really know limits of sqlite3 wrt kernel
> case. And again, what we need to do to retain history ...

I would't fret over that :-) the big issue I have with sqlite3 is that it
interacts horribly with ext3, resulting in dysmal journalled write
performance compared to ext2. I do not know if this is a sqlite3 or an ext3
problem though.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
