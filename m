Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVJ2E2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVJ2E2f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 00:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVJ2E2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 00:28:35 -0400
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:5114 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751133AbVJ2E2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 00:28:34 -0400
Message-Id: <6.2.3.4.0.20051028222139.03ff2fa0@no.incoming.mail>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.3.4
Date: Fri, 28 Oct 2005 22:28:28 -0600
To: Lee <linuxtwidler@gmail.com>
From: Jeff Woods <Kazrak+kernel@cesmail.net>
Subject: Re: Serial Port Sniffing
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051028132417.6d3dc843@localhost>
References: <20051028132417.6d3dc843@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10/28/2005 13:24 -0500, Lee <linuxtwidler@gmail.com> wrote:
>Does anyone have any experience with sniffing data from a serial 
>port w/o the device attached to the serial port or the application 
>having knowledge of this ?
>
>I had found an old kernel module (for 2.2.0, i think) called 'maxty' 
>which would does this.  Is there something equivalent for the 2.6.x kernels ?
>
>Or is there a better way to go about doing this?

Don't know about software sniffing but hardware sniffing of RS-232 is 
relatively simple. Splice in a "Y" cable and configure a serial port 
of another device to listen. Of course, you'll have to configure the 
serial port to the same rate, parity and stop bits but that's usually 
easy. Cut the transmit wire on the sniffer side to ensure nothing 
outbound succeeds in leaving the sniffer machine. Listening to both 
sides of the conversation would require two sniffer devices, or at 
least two serial ports.

--
Jeff Woods <kazrak+kernel@cesmail.net> 

