Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275276AbTHMQz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 12:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275279AbTHMQz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 12:55:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60627 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S275276AbTHMQz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 12:55:56 -0400
Subject: Re: 2.6.0-test3 "loosing ticks"
From: john stultz <johnstul@us.ibm.com>
To: timothy parkinson <t@timothyparkinson.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813014735.GA225@timothyparkinson.com>
References: <20030813014735.GA225@timothyparkinson.com>
Content-Type: text/plain
Organization: 
Message-Id: <1060793667.10731.1437.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Aug 2003 09:54:27 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-12 at 18:47, timothy parkinson wrote:
> the 2.6 kernels have been loosing time on my box, and i just noticed this
> message at the very bottom of dmesg that i think may relate:
> 
> Loosing too many ticks!
> TSC cannot be used as a timesource. (Are you running with SpeedStep?)
> Falling back to a sane timesource.
> 
> i'm running test-3 right now, but i've been seeing the same problem back into
> the 2.5 kernels.  any ideas?  it's a dual PIII coppermine, relatively close
> to default slackware 9, i'll attach the config in case that helps.  thanks in
> advance!

Sounds like either your PIT is running slowly or something is
consistently keeping the timer interrupt from being handled. In 2.4 do
you have any time related issues at all?  Does the "Loosing too many
ticks!" message correlate to any event on the system (boot, heavy load)?

Also listing system type, motherboard, any sort of funky devices you've
got might be helpful.

thanks
-john


