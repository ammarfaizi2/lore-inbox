Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270716AbTHAKrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272519AbTHAKqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:46:55 -0400
Received: from AMarseille-201-1-1-232.w193-252.abo.wanadoo.fr ([193.252.38.232]:53287
	"EHLO gaston") by vger.kernel.org with ESMTP id S270716AbTHAKok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:44:40 -0400
Subject: Re: Radeon in LK 2.4.21pre7
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Cc: ajoshi@kernel.crashing.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1058679793.10948.47.camel@ktkhome>
References: <1058679793.10948.47.camel@ktkhome>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059734588.8194.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 01 Aug 2003 12:43:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-20 at 07:43, Kristofer T. Karas wrote:
> Ben, Ani, et al,
> 
> Just tried Linux kernels 2.4.21pre6 and pre7 with my Radeon 8500LEE and
> have had some dreadful corruption problems related to pixel clearing
> during scroll and ypan.  This is probably old news to you; so <aol>me
> too</aol>.  I first noticed this in the -ac kernels, but a variant is
> now in mainline -pre.

Ok, your problem is weird and doesn't seem related to others I've been
reported, I suspect some engine initialization issue. Do you have a
pointer to a specific -ac patch that caused it with earlier versions
of the driver ? That would help tracking down what change actually
introduced it.

Ben.

