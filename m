Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbTDKTrj (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbTDKTrj (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:47:39 -0400
Received: from windsormachine.com ([206.48.122.28]:29970 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S261674AbTDKTri (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 15:47:38 -0400
Date: Fri, 11 Apr 2003 15:59:08 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: John Bradford <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <linux-hotplug-devel@lists.sourceforge.net>,
       <message-bus-list@redhat.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
In-Reply-To: <Pine.LNX.4.53.0304111553050.15140@chaos>
Message-ID: <Pine.LNX.4.33.0304111553380.14943-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003, Richard B. Johnson wrote:

> Every three-connection connector supplies power to two drives.
>
>      |--------D1
> -----|--------D2    ________D3
>      |______________|_______D4
>                     |_______Continue
Here's the way I thought of it.

                     |--x -- 3
       |--------X----|--x -- 3
       |             |--x -- 3
       |
       |             |--x -- 3
-------|--------X----|--x -- 3
       |             |--x -- 3
       |
       |             |--x -- 3
       |--------X----|--x -- 3
                     |--x -- 3

I now have 1 + 3 + 9 = 13 splitters, giving me 27 connections, out of 1.
etc, etc. Same numbers I'd have doing it your way, yours would be 13
levels deep instead.

I think I just went for the massively parallel method of hooking
these up and from there got massively lost.

Mike

