Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVLNRyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVLNRyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVLNRyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:54:13 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:58991 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S932406AbVLNRyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:54:12 -0500
Message-ID: <43A05C32.3070501@ru.mvista.com>
Date: Wed, 14 Dec 2005 20:53:54 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com> <20051213195317.29cfd34a.vwool@ru.mvista.com> <200512131101.02025.david-b@pacbell.net> <20051213191531.GA13751@kroah.com> <43A0230B.1040904@ru.mvista.com> <20051214171842.GB30546@kroah.com>
In-Reply-To: <20051214171842.GB30546@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>What is the speed of your SPI bus?
>
>And what are your preformance requirements?
>  
>
The maximum frequency for the SPI bus is 26 MHz, WLAN driver is to work 
at true 10 Mbit/sec.

Vitaly

P. S. I'm speaking not about this particular case during most part of 
this conversation. Sound cards behind the SPI bus will suffer a lot more 
since it's their path to use wXrY functions (lotsa small transfers) 
rather than WLAN's.
