Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265752AbUAKD6t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 22:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265753AbUAKD6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 22:58:49 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:48147 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265752AbUAKD6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 22:58:48 -0500
Date: Sat, 10 Jan 2004 22:58:31 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: What is codaauth? Why is Linux polling it?
In-Reply-To: <Pine.LNX.4.53.0401082135560.1311@chaos>
Message-ID: <Pine.LNX.4.44.0401102257510.14466-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Richard B. Johnson wrote:

> I have a RH System at home, no mods, right out of the box.
> It keeps sending UDP packets to 63.240.115.23.codaauth, so fast
> it's killing my PPP bandwidth.
> 
> Anybody know how to shut it up? There is no coda file-system on
> that machine (that I know of).

Figure out what program is sending the packets.

Chances are your bind got rooted. Guess why newer
RH distros have some kind of a firewall up by default?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

