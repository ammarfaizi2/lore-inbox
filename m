Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVGKUnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVGKUnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVGKUmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:42:15 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:24049 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S262656AbVGKUkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:40:43 -0400
Message-ID: <42D2D912.3090505@nortel.com>
Date: Mon, 11 Jul 2005 14:39:46 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <200506231828.j5NISlCe020350@hera.kernel.org>	 <20050708214908.GA31225@taniwha.stupidest.org>	 <20050708145953.0b2d8030.akpm@osdl.org>	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>	 <20050709203920.394e970d.diegocg@gmail.com>	 <1120934466.6488.77.camel@mindpipe>  <176640000.1121107087@flay> <1121113532.2383.6.camel@mindpipe>
In-Reply-To: <1121113532.2383.6.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> Tickless + sub HZ timers is a win for everyone, the multimedia people
> get better latency, and the laptop people get to run longer.

IIRC it's not a win for many systems.  Throughput goes down due to timer 
manipulation overhead.

Chris
