Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWFSRfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWFSRfT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWFSRfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:35:19 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:11486 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP
	id S1751071AbWFSRfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:35:11 -0400
Message-ID: <4496E041.5070501@nortel.com>
Date: Mon, 19 Jun 2006 11:34:57 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
References: <4492D5D3.4000303@atmos.washington.edu> <44948EF6.1060201@atmos.washington.edu> <Pine.LNX.4.61.0606191638550.23553@ask.diku.dk> <200606191724.31305.ak@suse.de>
In-Reply-To: <200606191724.31305.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2006 17:35:01.0617 (UTC) FILETIME=[B16D3610:01C693C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> Incoming packets are only time stamped
> when someone asks for the timestamps.

Doesn't that add scheduling latency to the timestamps?  Or is is a flag 
that gets set to trigger timestamping at packet arrival?

Chris
