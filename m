Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbTDYByJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 21:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbTDYByJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 21:54:09 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:38878 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262689AbTDYByH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 21:54:07 -0400
Date: Fri, 25 Apr 2003 03:05:36 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch?] SiS 746 AGP-Support
Message-ID: <20030425020530.GA18673@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>,
	linux-kernel@vger.kernel.org
References: <200304250224.50431.volker.hemmann@heim9.tu-clausthal.de> <20030425004003.GA12614@suse.de> <200304250302.26791.volker.hemmann@heim9.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304250302.26791.volker.hemmann@heim9.tu-clausthal.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 03:02:26AM +0200, Hemmann, Volker Armin wrote:

 > I have only a AGP 2 (geforce 4-mx) card, so I missed that(and with one I would 
 > only to be able to say 'it doesn't work' so thanks for your explanation). But 
 > without this changes I won't even able to use dga, because the first 
 > dga-enabled app completely locks up my box. 
 > And to have working AGP2 and non working APG3 looks a lot better for me than 
 > no AGP-support at all.  

Sure, I wasn't objecting per'se to the patch, but people should be made
aware it's not going to help them a tiny bit if they have an AGP3 card.
It may just abort nicely, it may take down the machine in horrible ways
depending on how well SiS handles reads/writes to disabled registers.

		Dave

