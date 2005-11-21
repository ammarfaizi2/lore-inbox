Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVKUIxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVKUIxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 03:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVKUIxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 03:53:16 -0500
Received: from znsun1.ifh.de ([141.34.1.16]:62685 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S932234AbVKUIxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 03:53:16 -0500
Date: Mon, 21 Nov 2005 09:52:20 +0100 (CET)
From: Patrick Boettcher <pb@linuxtv.org>
X-X-Sender: pboettch@pub3.ifh.de
To: Johannes Stezenbach <js@linuxtv.org>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, Jeremy Nysen <jnysen@idx.com.au>
Subject: Re: [linux-dvb-maintainer] Multiple USB DVB devices cause hard   
 lockups
In-Reply-To: <20051120021719.GC8157@linuxtv.org>
Message-ID: <Pine.LNX.4.64.0511210942360.1390@pub3.ifh.de>
References: <20051109135925.GF12751@localhost.localdomain>
 <20051120021719.GC8157@linuxtv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy, I added you to this discussion, because obviously you are 
suffering the same problem.

On Sun, 20 Nov 2005, Johannes Stezenbach wrote:
>>    I'm trying to get a pair of Twinhan Alpha II DVB-USB devices
>> working on the same machine. With a single device plugged in, I can
>> quite easily receive and stream data.
>
> Maybe Patrick can comment, I believe he tested with multiple
> USB devices.

Sorry Johannes, that it seems I'm always waiting for your alarm to make me 
write a Mail - but this time I cannot add anything to find the problem - 
or maybe I can - not sure :):

I tested it with multiple dvb-usb devices in parallel - but never with 2 
Twinhan Alpha boxes.

Just a thought: Hugo, can you enable dvb-usb-debug and load the dvb-usb.ko 
with parameter debug=9 .

Then start the transfer and your syslog will be filled with messages of 
returning USB-buffers and their sizes. Try to catch some lines from both 
devices and send them here.

regards,
Patrick.
