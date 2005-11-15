Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVKOQxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVKOQxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVKOQxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:53:24 -0500
Received: from znsun1.ifh.de ([141.34.1.16]:14758 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S964948AbVKOQxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:53:22 -0500
Date: Tue, 15 Nov 2005 17:52:41 +0100 (CET)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub3.ifh.de
To: Johannes Stezenbach <js@linuxtv.org>
Cc: Chris Rankin <rankincj@yahoo.com>, linux-dvb-maintainer@linuxtv.org,
       David Brigada <brigad@rpi.edu>, linux-kernel@vger.kernel.org,
       Deti Fliegl <deti@fliegl.de>
Subject: Re: [linux-dvb-maintainer] Re: [OOPS] Linux 2.6.14.2 and DVB USB
In-Reply-To: <20051115164321.GA4331@linuxtv.org>
Message-ID: <Pine.LNX.4.64.0511151747050.29360@pub3.ifh.de>
References: <20051114235102.64514.qmail@web52912.mail.yahoo.com>    
 <Pine.LNX.4.64.0511150939010.18517@pub3.ifh.de>     <20051115152823.GA4079@linuxtv.org>
     <Pine.LNX.4.64.0511151633490.29360@pub3.ifh.de> <20051115164321.GA4331@linuxtv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005, Johannes Stezenbach wrote:
>> If I could fix it in in dvb-usb, then it would be again only fixed for a
>> small amount of devices. For DVB-PCMCIA-cards using the default
>> fe-architecture will also cause Oopses like that, when unplugging while
>> having the device in use. That's why, IMHO, the dvb-core should be made
>> hotplug-safe, not a single driver. Even worse: it's not just the
>> frontend-device-nodes, but also the demux-nodes (and I think the other
>> onces too).
>
> I agree. Could you post a summary of your conversation with Deti to
> linux-dvb so someone else could start working on it?

Actually, that was the summary :). He said, it should be more generally 
done, I suggested him to look into dvbdev.c, then he said is too busy.

In one email he explained his mechanism to me, but you can understand it 
also by looking at his cinergy-patch, I think.

Patrick.
