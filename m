Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbUCXAby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 19:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbUCXAby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 19:31:54 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:37636 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262942AbUCXAbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 19:31:53 -0500
Date: Wed, 24 Mar 2004 01:31:45 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: Thinkpad 560X w/ 160MB memory (2.4.24 kernel): many segfaults
Message-ID: <20040324003145.GA9637@alpha.home.local>
References: <200403230847.05533.vda@port.imtp.ilyichevsk.odessa.ua> <E1B5ubY-0003Om-00@coll.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1B5ubY-0003Om-00@coll.ra.phy.cam.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 10:42:40PM +0000, Sanjoy Mahajan wrote:
> > burnBX (from cpuburn) could detect the problem within 8 seconds.
> > [or burnMMX]
> 
> Thanks for these suggestions.  I ran each for several minutes and got
> no errors.  So I'm still puzzled, but maybe it is a subtle memory
> incompatability that neither program detects (yet somehow Linux works
> the machine so hard and uncovers it?).

Sorry, but IIRC both burnBX and burnMMX don't test a large portion of RAM,
but only a small amount (4 MB ?) by default. So it's fairly possible that
without options, it runs on your on-board RAM only. I believe you had to
specify it a letter as a first and only parameter. I used 'P' which meant
64 MB. I don't remember if you have higher sizes, but at least you can
start several of them in parallel to lock more memory.

Willy

