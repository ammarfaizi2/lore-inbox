Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287838AbSA2AOR>; Mon, 28 Jan 2002 19:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287833AbSA2AOA>; Mon, 28 Jan 2002 19:14:00 -0500
Received: from zero.tech9.net ([209.61.188.187]:17934 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287827AbSA2ANs>;
	Mon, 28 Jan 2002 19:13:48 -0500
Subject: Re: Rik van Riel's vm-rmap
From: Robert Love <rml@tech9.net>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <1012263259.1634.3.camel@tiger>
In-Reply-To: <Pine.LNX.4.33L.0201280613510.32617-100000@imladris.surriel.com> 
	<1012262826.1634.1.camel@tiger>  <1012263182.817.9.camel@phantasy> 
	<1012263259.1634.3.camel@tiger>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 28 Jan 2002 19:19:19 -0500
Message-Id: <1012263560.817.11.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-28 at 19:14, Louis Garcia wrote:
> Should I do the rmap patch first?

Yes, if Andrew's low-latency patch fails you just lose the scheduling
points in vmscan.c (big deal).  If rmap half applies... ouch.

So apply rmap first.

	Robert Love

