Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTI3Qe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 12:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTI3Qe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 12:34:27 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:984 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261744AbTI3Qe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 12:34:26 -0400
Date: Tue, 30 Sep 2003 18:34:25 +0200
From: bert hubert <ahu@ds9a.nl>
To: Christoph Klocker <cklocker@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: datatransfer slow down with 1TB files
Message-ID: <20030930163425.GA27770@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Christoph Klocker <cklocker@kth.se>, linux-kernel@vger.kernel.org
References: <3F796B6B.8070505@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F796B6B.8070505@kth.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 01:39:23PM +0200, Christoph Klocker wrote:

> the sequential output stays at 183MB/s any time, up to 1TB.
> As my harddisks have a sustained rate of 32-50 MB/s each it should not 
> be the

Do they also have that rate near the spindle? Try creating 10 100GB files
and see if they all have the same rate.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
