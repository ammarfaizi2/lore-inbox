Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbTBBLjK>; Sun, 2 Feb 2003 06:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTBBLjK>; Sun, 2 Feb 2003 06:39:10 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:47818 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S265198AbTBBLjJ>;
	Sun, 2 Feb 2003 06:39:09 -0500
Date: Sun, 2 Feb 2003 12:48:38 +0100
From: bert hubert <ahu@ds9a.nl>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: problems achieving decent throughput with latency.
Message-ID: <20030202114838.GA16831@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Ben Greear <greearb@candelatech.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3E3CCADA.6080308@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E3CCADA.6080308@candelatech.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 01, 2003 at 11:38:02PM -0800, Ben Greear wrote:
> I am testing my latency-insertion tool, and I notice that tcp will not use
> all of the available bandwidth if there is any significant amount of latency
> on the wire.
> 
> For example, with 25ms latency in both directions, I see about 8Mbps
> bi-directional throughput.

Check if large windows are being used, if window scaling is enabled.

Regards,

bert


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
