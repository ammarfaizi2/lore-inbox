Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbTDYVLP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263989AbTDYVLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:11:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29967 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263986AbTDYVLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:11:13 -0400
Message-ID: <3EA9A72F.4030505@zytor.com>
Date: Fri, 25 Apr 2003 14:22:55 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 9-track tape drive (Was: Re: versioned filesystems in linux)
References: <200304252121.h3PLLwSX002318@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200304252121.h3PLLwSX002318@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>>Of bigger concern is that the inter-block gap is only 0.5 (or maybe 0.75
>>>inches, the memories are dim ;) - and you need to be able to stop and then get
>>>back up to speed in that distance (or decelerate, rewind, and get a running
>>>start).
>>>
>>
>>No, you don't.  You just need to make sure you don't have the head
>>active while you overshoot.  Performance will *definitely* suffer if
>>you don't, though, since you'd have to rewind.
> 
> 
> Well, we could make our device dual speed, and either run at E.G. 60
> I.P.S. or 120 I.P.S. depending on whether we want to read a large
> block of data, or just one block that happens to be closer to the
> current head position than the distance we need to accellerate to 120
> I.P.S.
> 

Actually, as long as you get enough read speed across the head and can
actually measure the real speed you can presumably vary the speed
arbitrarily, all the way up to the breaking point of the medium.

	-hpa


