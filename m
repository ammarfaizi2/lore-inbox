Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbUBEP3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 10:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbUBEP3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 10:29:36 -0500
Received: from [129.183.4.3] ([129.183.4.3]:31890 "EHLO ecbull20.frec.bull.fr")
	by vger.kernel.org with ESMTP id S265332AbUBEP3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 10:29:34 -0500
From: johann lombardi <johann.lombardi@bull.net>
Reply-To: johann.lombardi@bull.net
Organization: BULL S.A.
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Thu, 5 Feb 2004 16:31:40 +0100
User-Agent: KMail/1.5.4
Cc: vojtech@suse.cz, ctpm@rnl.ist.utl.pt
References: <200402041820.39742.wnelsonjr@comcast.net> <200402050454.44936.ctpm@rnl.ist.utl.pt> <200402051440.16116.mbuesch@freenet.de>
In-Reply-To: <200402051440.16116.mbuesch@freenet.de>
MIME-Version: 1.0
Message-Id: <200402051631.41016.johann.lombardi@bull.net>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 05/02/2004 16:34:56,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 05/02/2004 16:35:02,
	Serialize complete at 05/02/2004 16:35:02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Feb  4 18:19:46 vega kernel: psmouse.c: Wheel Mouse at
> isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.

I had the same issue with 2.6.1. Always under heavy disk activity. 
Turning on DMA support for my hard drive sovled the problem.

However, I've recently upgraded to 2.6.2-rc2 and the problem has reappeared.
This time, it is not linked to disk activity (DMA support is now enabled). 
http://kerneltrap.org/node/view/2199 does not solve the problem.
Still investigating ...

Greetings,
Johann

ps: my kernel is not tainted.

