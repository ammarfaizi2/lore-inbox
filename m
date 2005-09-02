Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbVIBNsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbVIBNsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 09:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVIBNsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 09:48:40 -0400
Received: from ns2.limegroup.com ([66.92.115.81]:40583 "EHLO ns2.limegroup.com")
	by vger.kernel.org with ESMTP id S1751316AbVIBNsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 09:48:39 -0400
Date: Fri, 2 Sep 2005 09:48:21 -0400 (EDT)
From: Ion Badulescu <ion.badulescu@limegroup.com>
X-X-Sender: ion@guppy.limebrokerage.com
To: Guillaume Autran <gautran@mrv.com>
cc: John Heffner <jheffner@psc.edu>, Ion Badulescu <lists@limebrokerage.com>,
       "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x
 kernels
In-Reply-To: <43184D79.6040009@mrv.com>
Message-ID: <Pine.LNX.4.61.0509020945550.6083@guppy.limebrokerage.com>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com>
 <20050901.154300.118239765.davem@davemloft.net>
 <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
 <2d02c76a84655d212634a91002b3eccd@psc.edu> <43184D79.6040009@mrv.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005, Guillaume Autran wrote:

> I experienced the very same problem but with window size going all the way 
> down to just a few bytes (14 bytes). dump files available upon requests :)
> Ion, how were you able to reproduce the issue ? Can the same type of traffice 
> always reproduce the issue or is it more intermittent ?

I have no problem whatsoever reproducing it, at least with the kind of 
traffic I described. I had 4 flows like that running yesterday, and all 4 
had TCP window sizes smaller than 500 bytes on the receiver by mid-day.

-Ion
