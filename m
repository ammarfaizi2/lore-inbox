Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWEGOkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWEGOkI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 10:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWEGOkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 10:40:07 -0400
Received: from rtr.ca ([64.26.128.89]:40411 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932166AbWEGOkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 10:40:05 -0400
Message-ID: <445E06C3.3000904@rtr.ca>
Date: Sun, 07 May 2006 10:40:03 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Roy Rietveld <rwm_rietveld@hotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-os@analogic.com,
       jengelh@linux01.gwdg.de
Subject: Re: TCP/IP send, sendfile, RAW
References: <BAY105-F393958BBFE20D29F8C6C82E9B40@phx.gbl>
In-Reply-To: <BAY105-F393958BBFE20D29F8C6C82E9B40@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Rietveld wrote:
> Yes it is 100 MBits and there is a listener. and there are no other pc's 
> on the link because its cross cable link. And when sending large buffers 
> 32Kbyte it will do 80 MBits. It think that there is a lot of overhead in 
> the fucntion send or something.

I'm not sure what the problem is here.  I just now cobbled together 
a pair of programs using SOCK_RAW, and ran the sender on my notebook
and the receiver on a 600Mhz VIA EPIA box, with a consumer grade 100mb/sec
switch in the middle.

Throughput was 98.4 mbits/sec using 1400 byte buffers.

Cheers
