Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261765AbTCYJCe>; Tue, 25 Mar 2003 04:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbTCYJCe>; Tue, 25 Mar 2003 04:02:34 -0500
Received: from f8.pav2.hotmail.com ([64.4.37.8]:4875 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261765AbTCYJBd>;
	Tue, 25 Mar 2003 04:01:33 -0500
X-Originating-IP: [129.219.25.77]
X-Originating-Email: [bhushan_vadulas@hotmail.com]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: send and recv function for UDP
Date: Tue, 25 Mar 2003 09:12:38 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F8Z06YO4OPXok84FTA700005a3e@hotmail.com>
X-OriginalArrivalTime: 25 Mar 2003 09:12:38.0497 (UTC) FILETIME=[AE759D10:01C2F2AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
An I use sock_recvmsg() sock_sendmsg() function to send data on a UDP socket 
opened in a kernel module?

The problem is, when I use sock_recvmsg at the server side, it will  not 
wait at all for the client to send data. It behaves asynchronously. It will 
come out with received count as zero.

I cannot use, sock_read since I cannot get the (struct file *), a required 
parameter and there is no function like sock_recvfrom which is conunter part 
of recvfrom for kernel programming.

These were the options I tried. Could any one suggest how to come around the 
problem for sending data using UDP in a kernel module.

Thanking You
Shesha

_________________________________________________________________
Call US for just Rs. 5. http://www.msn.co.in/webtelephony/ Get a phone card

