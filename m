Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbTD1XjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 19:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbTD1XjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 19:39:25 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:15298 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261174AbTD1XjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 19:39:25 -0400
Date: Tue, 29 Apr 2003 00:50:23 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030428235023.GE26105@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD44BF.30808@gmx.net> <20030428151648.GF4525@Wotan.suse.de> <3EAD5C44.103@us.ibm.com> <483810000.1051549109@[10.10.2.4]> <20030428224025.GW30441@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428224025.GW30441@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 03:40:25PM -0700, William Lee Irwin III wrote:

 > Most of the driver stuff I've seen is ioremap() of O(PAGE_SIZE) which
 > just gets denied so it fails to probe. IDE was worse (as usual), and
 > AGP needed an unusual amount of tweaking, which probably will be
 > typical for the graphics drivers in general.

Is this stuff in the current pgcl patch? I've not looked at it,
but wouldn't mind a look-see sometime.

		Dave
