Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267767AbTBLTNQ>; Wed, 12 Feb 2003 14:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267729AbTBLTMb>; Wed, 12 Feb 2003 14:12:31 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:39312 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267701AbTBLTM2>;
	Wed, 12 Feb 2003 14:12:28 -0500
Date: Wed, 12 Feb 2003 19:16:57 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Panic `cat /proc/ioports`
Message-ID: <20030212191657.GB20660@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <20030212102540.7fe1e55d.rddunlap@osdl.org> <Pine.LNX.3.95.1030212135439.8872A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1030212135439.8872A-100000@chaos.analogic.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 01:56:58PM -0500, Richard B. Johnson wrote:

 > Yes! pcnet32 to start. Practically all the network drivers end up
 > doing this if they fail somewhere in the initialization. I didn't
 > get a chance to look at others. I got called away for a "work break".

You might want to try using a more recent kernel for auditting purposes,
.18 is just shy of a year old now, and a lot has changed in various
network drivers.  The region handling of pcnet32 looks to be fixed
since rev1.23.1.1 at least.

	Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
