Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265328AbSKEXKg>; Tue, 5 Nov 2002 18:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265329AbSKEXKf>; Tue, 5 Nov 2002 18:10:35 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:19357 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S265328AbSKEXKN>;
	Tue, 5 Nov 2002 18:10:13 -0500
Date: Wed, 6 Nov 2002 00:16:49 +0100
From: bert hubert <ahu@ds9a.nl>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, jw schultz <jw@pegasys.ws>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <20021105231649.GA14511@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Peter Chubb <peter@chubb.wattle.id.au>, jw schultz <jw@pegasys.ws>,
	LKML <linux-kernel@vger.kernel.org>
References: <15816.19206.959160.739312@wombat.chubb.wattle.id.au> <26610000.1036541181@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26610000.1036541181@flay>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 04:06:21PM -0800, Martin J. Bligh wrote:

> The locking of walking the tasklist seems non-trivial, but we may well
> end up with something like that. By the time you finish, it looks more
> like a /dev device thing than /proc (which I'm fine with), and looks

Can people just oprofile this instead of guessing? Opening a file is not
very expensive anymore, so if ps is noticeably slow, it must be something
else.

'To measure is to know'

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
