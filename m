Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbTAHGP4>; Wed, 8 Jan 2003 01:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTAHGP4>; Wed, 8 Jan 2003 01:15:56 -0500
Received: from rth.ninka.net ([216.101.162.244]:40360 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267524AbTAHGPz>;
	Wed, 8 Jan 2003 01:15:55 -0500
Subject: Re: Broadcom Gigabit 5703 and Bridging
From: "David S. Miller" <davem@redhat.com>
To: sbolderoff@foursticks.com
Cc: Paul Schulz <pschulz@foursticks.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030108044155.GA1473@fuzzy.foursticks.com.au>
References: <E18W7jh-0001Co-00@mars> 
	<20030108044155.GA1473@fuzzy.foursticks.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Jan 2003 22:58:35 -0800
Message-Id: <1042009115.17193.3.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 20:41, sbolderoff@foursticks.com wrote:
> On Wed, Jan 08, 2003 at 02:52:37PM +1030, Paul Schulz wrote:
> The BCM95703A30 rev 1002 has issues with the hardware checksumming.

Really?

Can you demonstrate the problem with the 5703 without bridging?
Can you demonstrate the problem with bridging and another checksum
capable card?

Unless you can answer both those questions, I think faulting this
5703 variant is premature.  It smells more like a briding bug to
me, perhaps it's corrupting the hw checksumming state of an SKB
as it passes through the bridging layer.

