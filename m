Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272403AbTHIQAO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 12:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272405AbTHIQAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 12:00:14 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:43419 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S272403AbTHIQAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 12:00:11 -0400
Date: Sat, 9 Aug 2003 17:59:16 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre10 Problems with radeonfb and suspend mode
Message-ID: <20030809155916.GA28820@puettmann.net>
References: <20030804181307.GB31178@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804181307.GB31178@puettmann.net>
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19lW7g-0007V7-00*tjcSIsYeiWg* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 08:13:07PM +0200,  wrote:
> 
>         hello,
> 
> If i load the radeonfb module and send my thinkpad with apm -s to
> suspend all seems fine but on comming back the screen is still black.
> 
> Kernel: 2.4.22-pre10 
> Hardware: Thinkpad R40 2722 / Sony Z1
>           01:00.0 VGA compatible controller: ATI Technologies Inc 
>           Radeon Mobility M7 LW [Radeon Mobility 7500]
> 

Later Tests show that :

#! /usr/bin/bash
rmmod radeonfb
sleep 10
modprobe radeonfb 

freeze the laptop. 

            ruben


-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
