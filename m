Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbUAHFVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 00:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbUAHFVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 00:21:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:9741 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263771AbUAHFUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 00:20:19 -0500
Date: Thu, 8 Jan 2004 06:20:00 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: Problem with 2.4.24 e1000 and keepalived
Message-ID: <20040108052000.GA8829@alpha.home.local>
References: <20040107200556.0d553c40.skraw@ithnet.com> <20040107210255.GA545@alpha.home.local> <3FFCC430.4060804@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFCC430.4060804@candelatech.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Wed, Jan 07, 2004 at 06:45:04PM -0800, Ben Greear wrote:
 
> You have to bring the interface 'UP' before it will detect link,
> with something like:  ifconfig eth2 up

Don't you mean "after" instead of "before" here ? Because the case where
it doesn't work is when everything is set up while the cable is unplugged,
but conversely, if the system goes up with the cable plugged, setting the
interface UP detects the link as UP and works. I believe that the problem
is related to setting the interface UP with nothing plugged into it.

Cheers,
Willy

