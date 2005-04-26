Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVDZPNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVDZPNH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDZPNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:13:02 -0400
Received: from gate.in-addr.de ([212.8.193.158]:5541 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261567AbVDZPMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:12:53 -0400
Date: Tue, 26 Apr 2005 17:12:31 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: John Stoffel <john@stoffel.org>, Jamie Lokier <jamie@shareable.org>
Cc: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>, Ville Herva <v@iki.fi>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050426151231.GF7859@marowsky-bree.de>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org> <17006.22498.394169.98413@smtp.charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17006.22498.394169.98413@smtp.charter.net>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-26T11:01:54, John Stoffel <john@stoffel.org> wrote:

> Jamie> No.  A transaction means that _all_ processes will see the
> Jamie> whole transaction or not.
> This is really hard.  How do you handle the case where process X
> starts a transaction modifies files a, b & c, but process Y has file b
> open for writing, and never lets it go?  Or the file gets unlinked?  

I suggest you ask Hans, reiser4 does have such a feature if I recall
correctly.

It gets a whole lot more interesting if you want the sucker to spawn
more than one mount though.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

