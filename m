Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271175AbTGQQtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271445AbTGQQtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:49:09 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:62982 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271175AbTGQQtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:49:06 -0400
Date: Thu, 17 Jul 2003 18:03:59 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Michael Kristensen <michael@wtf.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unable to boot linux-2.6-test1
In-Reply-To: <20030715185852.GA519@sokrates>
Message-ID: <Pine.LNX.4.44.0307171803120.10255-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> * Dave Jones <davej@codemonkey.org.uk> [2003-07-15 20:33:00]:
> >> CONFIG_INPUT=m
> > Because this is m, Kconfig is hiding CONFIG_VT from you.
> 
> When I read the help for CONFIG_VT, I was convinced that was it, but
> when I tried to enable CONFIG_VT it still didn't work. It just sounded
> so like that was it. Any other suggestions?
> 
> By the way.. I am subscribed to this list now, so no need to CC anymore,
> but thanks for the reply.

Check to see which console drivers and how many framebuffer drivers you 
have enabled. Most peopel have been enabling everything which is wrong.


