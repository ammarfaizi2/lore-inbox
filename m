Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSJKPDs>; Fri, 11 Oct 2002 11:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262488AbSJKPDs>; Fri, 11 Oct 2002 11:03:48 -0400
Received: from moe.rice.edu ([128.42.5.4]:27611 "EHLO moe.rice.edu")
	by vger.kernel.org with ESMTP id <S262486AbSJKPDs>;
	Fri, 11 Oct 2002 11:03:48 -0400
Message-ID: <00c701c27138$69de9fa0$2476a018@OMIT>
From: "omit_ECE" <omit@rice.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Implementation problems in tcp
Date: Fri, 11 Oct 2002 10:10:16 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a project to implement some functions in TCP.
First, I wanna calculate the one-way delay by time_stamp
in TCP Acks; ie, rcv_tsval & rvc_tsecr in tcp_input.c. But 
I am not quite sure in which functions, ex. tcp_rcv_established, 
the two values (rcv_tsval & rvc_tsecr) are what I want.

Second, I want to use ECN as an indicator and add some 
conditions. But I really cannot figure out what is going on 
in tcp_input.c. Could anyone give me some hints please?
Thanks.

YuZen
