Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbSKFADe>; Tue, 5 Nov 2002 19:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265397AbSKFADe>; Tue, 5 Nov 2002 19:03:34 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:33437 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S265396AbSKFADb>;
	Tue, 5 Nov 2002 19:03:31 -0500
Date: Wed, 6 Nov 2002 01:10:07 +0100
From: bert hubert <ahu@ds9a.nl>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, jw schultz <jw@pegasys.ws>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <20021106001007.GA15200@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Peter Chubb <peter@chubb.wattle.id.au>, jw schultz <jw@pegasys.ws>,
	LKML <linux-kernel@vger.kernel.org>
References: <15816.19206.959160.739312@wombat.chubb.wattle.id.au> <26610000.1036541181@flay> <20021105231649.GA14511@outpost.ds9a.nl> <27920000.1036544267@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27920000.1036544267@flay>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 04:57:47PM -0800, Martin J. Bligh wrote:

> > 'To measure is to know'
> 
> Errm... we have profiled it. Look at the subject line ... this started
> off as a dcache_rcu discussion. The dcache lookup ain't cheap, for 
> starters, but that's not really the problem ... it's O(number of tasks),
> which sucks.

Ok - but if opening a few files is the problem, the solution is not to roll
those files into one but to figure out why opening the files is slow in the
first place.

Apologies for misinterpreting some of the comments I saw, I'm a bit hyper
from my futex documenting spree.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
