Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264927AbRGSQbO>; Thu, 19 Jul 2001 12:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265101AbRGSQbE>; Thu, 19 Jul 2001 12:31:04 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:29198 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S264927AbRGSQap>; Thu, 19 Jul 2001 12:30:45 -0400
Date: Thu, 19 Jul 2001 12:30:49 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Request for comments
Message-ID: <20010719123049.B12691@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0107191757400.17990-100000@groove.rdsnet.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0107191757400.17990-100000@groove.rdsnet.ro>; from ctrl@rdsnet.ro on Thu, Jul 19, 2001 at 06:44:52PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

++ 19/07/01 18:44 +0300 - Cornel Ciocirlan:
> a) more efficient packet filtering. After a cache entry is created for a
> flow,  we apply the ACLs for the packet and associate the action with the
> flow. All subsequent packets belonging to the same flow will be
> dropped/accepted without re-appying the packet filtering rules

I'm seeing an identification problem arise here. You have to be able to
identify packets in a flow robustly, and you have to be able to spot packets
trying to fake it. I dont see any way in which you will be able to avoid
the packet filtering rules here.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
