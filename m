Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWEEI7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWEEI7N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 04:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWEEI7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 04:59:13 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:56789 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750937AbWEEI7M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 04:59:12 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "Roy Rietveld" <rwm_rietveld@hotmail.com>
Subject: Re: TCP/IP send, sendfile, RAW
Date: Fri, 5 May 2006 11:57:52 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <BAY105-F1952B97471150282623600E9B40@phx.gbl>
In-Reply-To: <BAY105-F1952B97471150282623600E9B40@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605051157.52589.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 May 2006 20:19, Roy Rietveld wrote:
> Can somebody help me with this.
> 
> I'am new to Linux normaly i do programming for RTOS.
> 
> I would like to send ethernet packets with 1400 bytes payload.
> I wrote a small program witch sends a buffer of 1400 bytes in a endless 
> loop.
> The problem is that a would like 100Mbits throughtput but when i check this 
> with ethereal.
> I only get 40 MBits. I tried sending with an UDP socket and RAW socket. I 
> also tried sendfile.
> The RAW socket gives the best result till now 50 MBits throughtput.
> 
> Is there something faster then send or am i doing something wrong.

Get netcat source and read it. It's small.

netcat is definitely able to saturate 100Mbit link with both TCP and UDP.
--
vda
