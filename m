Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTD1XzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 19:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbTD1XzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 19:55:06 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:29891 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261265AbTD1XzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 19:55:05 -0400
Date: Tue, 29 Apr 2003 01:06:02 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030429000602.GA32260@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD44BF.30808@gmx.net> <20030428151648.GF4525@Wotan.suse.de> <3EAD5C44.103@us.ibm.com> <483810000.1051549109@[10.10.2.4]> <20030428224025.GW30441@holomorphy.com> <20030428235023.GE26105@suse.de> <20030429000014.GA30441@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030429000014.GA30441@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 05:00:14PM -0700, William Lee Irwin III wrote:

 > AGP was fiddling around with something, which very well may
 > have been some kind of GART aperture for all I know about it, and needed
 > to use MMUPAGE_SIZE to think of its size correctly.

A lot of GARTs can only operate on 4KB pages. As long as this is kept in
mind, things should tick along just fine. Even those that can operate
with different size pages, we still treat as 4KB.
 
		Dave

