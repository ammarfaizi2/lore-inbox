Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317876AbSIJSNC>; Tue, 10 Sep 2002 14:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSIJSMJ>; Tue, 10 Sep 2002 14:12:09 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:6046 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317862AbSIJSLO>; Tue, 10 Sep 2002 14:11:14 -0400
Date: Tue, 10 Sep 2002 20:38:36 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Gunther Mayer <gunther.mayer@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <3D7E34DA.7010100@gmx.net>
Message-ID: <Pine.LNX.4.44.0209102036300.1100-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002, Gunther Mayer wrote:

> This method is flawed for edge-triggered interrupts: you will miss any
> interrupts which come in before you acked the first.

We ack the PIC before doing the handler walk.

	Zwane
-- 
function.linuxpower.ca

