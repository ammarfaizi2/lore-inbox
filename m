Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265096AbUFATwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265096AbUFATwS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265184AbUFATwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:52:18 -0400
Received: from outmx005.isp.belgacom.be ([195.238.2.102]:49802 "EHLO
	outmx005.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265096AbUFATwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:52:16 -0400
Subject: Re: why swap at all?
From: FabF <fabian.frederick@skynet.be>
To: Valdis.Kletnieks@vt.edu
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200406011902.i51J2mZ3016721@turing-police.cc.vt.edu>
References: <E1BUwEH-00030X-00@calista.eckenfels.6bone.ka-ip.net>
	 <1086114982.2278.5.camel@localhost.localdomain>
	 <200406011902.i51J2mZ3016721@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1086119611.2278.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 01 Jun 2004 21:53:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-01 at 21:02, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 01 Jun 2004 20:36:23 +0200, FabF said:
> 
> > I guess we have a design problem right here.We could add per-process
> > swappiness attribute.That swap thread becomes boring coz we're looking
> > globally what's going wrong locally.
> 
> Hmm.. do we need to worry about the same DoS issues we need to worry about with
> mlock and friends?  I know I can trust myself to not do stupid things to said
> flags on my laptop (well... not twice anyhow ;).  On the other hand, I have
> systems with clueless users, and the even more dangerous half-clued users.  And
> then I have a bunch of machines in our security lab, where Bad Things happen
> all the time... 

I was thinking about some rule e.g. any process using libX* isn't
swapped to disk until OOM ...

