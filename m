Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264249AbTICTjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTICTiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:38:06 -0400
Received: from pop.gmx.net ([213.165.64.20]:56259 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264249AbTICThR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:37:17 -0400
Date: Wed, 3 Sep 2003 21:36:44 +0200
From: Sebastian Reichelt <SebastianR@gmx.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.21] orinoco_cs card reinsertion
Message-Id: <20030903213644.1a56a7f2.SebastianR@gmx.de>
In-Reply-To: <Pine.LNX.4.44.0309031420480.6102-100000@logos.cnet>
References: <20030831160544.2d342b72.SebastianR@gmx.de>
	<Pine.LNX.4.44.0309031420480.6102-100000@logos.cnet>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you please try 2.4.22? It contains orinoco changes including in
> the area you changed. 

Sorry, 2.4.22 (from kernel.org) just hangs when I insert the card, after
the first of two beeps. Ctrl-Alt-Del doesn't work. No messages are
printed except the usual "cs: memory probe 0xa0000000-0xa0ffffff:
clean.", and syslog doesn't seem to have been flushed (it's cut off at
a higher position).

One thing I noticed from syslog is that the socket is assigned another
IRQ: 5 instead of 9.

-- 
Sebastian Reichelt
