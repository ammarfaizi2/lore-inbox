Return-Path: <linux-kernel-owner+w=401wt.eu-S1751177AbXAPN6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbXAPN6u (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 08:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXAPN6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 08:58:50 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:60345 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbXAPN6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 08:58:49 -0500
Date: Tue, 16 Jan 2007 14:57:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sami Farin <7atbggg02@sneakemail.com>
cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I broke my port numbers :(
In-Reply-To: <20070115224801.GB3771@m.safari.iki.fi>
Message-ID: <Pine.LNX.4.61.0701161457240.23841@yvahk01.tjqt.qr>
References: <20070115215515.GA3771@m.safari.iki.fi> <20070115224801.GB3771@m.safari.iki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: Re: I broke my port numbers :(
>
>On Mon, Jan 15, 2007 at 23:55:15 +0200, Sami Farin wrote:
>> I know this may be entirely my fault but I have tried reversing
>> all of my _own_ patches I applied to 2.6.19.2 but can't find what broke this.
>> I did three times "netcat 127.0.0.69 42", notice the different
>> port numbers.
>
>Hmm...  when I do "rmmod iptable_nat ip_nat", it works.

Then please show us your rulset that was loaded (iptables-save) before 
you removed the modules.


	-`J'
-- 
