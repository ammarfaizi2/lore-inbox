Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUFBM5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUFBM5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUFBM5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:57:32 -0400
Received: from tag.witbe.net ([81.88.96.48]:57770 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S262503AbUFBM5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:57:16 -0400
Message-Id: <200406021257.i52CvEX31840@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Subject: TCP retransmission : how to detect from an application ?
Date: Wed, 2 Jun 2004 14:57:11 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRIoR6je/XkQ3h9TO+dPHUfs7QeBQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've an application that is establishing TCP connection, and exchanges some
data.
However, from time to time, I suspect there are some packet loss, which are
corrected by the kernel (hell, TCP is reliable, isn't it :-), but I'd like
to know if an application can detect this (well, I don't want to be notified
of a packet loss once detected, but I'd like to get some stats before
closing
the connection).

Is there something possible ? Some ioctl ? Some /proc/magic-interface ?

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 

 


