Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbTLPAxh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 19:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbTLPAxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 19:53:37 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:64644 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264942AbTLPAxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 19:53:36 -0500
Date: Tue, 16 Dec 2003 00:52:51 +0000
From: Jamie Lokier <jamie@shareable.org>
To: George Anzinger <george@mvista.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Guillaume Foliard <guifo@wanadoo.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: Scheduler degradation since 2.5.66
Message-ID: <20031216005251.GB3364@mail.shareable.org>
References: <200312142048.51579.guifo@wanadoo.fr> <3FDD205A.6040807@cyberone.com.au> <3FDD35F9.7090709@cyberone.com.au> <3FDE5449.60507@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDE5449.60507@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Try running the test with a requested sleep time of something less than 
> 0.999849 ms.  All this is for the x86 which is using this time to do the 
> best it can with the PIT which can only get this close to 1 ms ticks.  You 
> can even vary this number to see exactly where the round up actually 
> happens.  Ah, life in the nano world :)

Would it be better to program the PIT for lowest frequency that's >= 1.0ms.

-- Jamie
