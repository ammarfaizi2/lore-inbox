Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWFSUun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWFSUun (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWFSUun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:50:43 -0400
Received: from ns1.suse.de ([195.135.220.2]:15256 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932221AbWFSUul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:50:41 -0400
From: Andi Kleen <ak@suse.de>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Date: Mon, 19 Jun 2006 22:39:37 +0200
User-Agent: KMail/1.8
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <4492D5D3.4000303@atmos.washington.edu> <200606191724.31305.ak@suse.de> <4496E041.5070501@nortel.com>
In-Reply-To: <4496E041.5070501@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606192239.37533.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 19:34, Chris Friesen wrote:
> Andi Kleen wrote:
> > Incoming packets are only time stamped
> > when someone asks for the timestamps.
>
> Doesn't that add scheduling latency to the timestamps?  Or is is a flag
> that gets set to trigger timestamping at packet arrival?

It's a flag (or more precise a global counter) 

-Andi
