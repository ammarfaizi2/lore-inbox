Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTGFWBG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 18:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTGFWBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 18:01:06 -0400
Received: from mpls-qmqp-02.inet.qwest.net ([63.231.195.113]:34569 "HELO
	mpls-qmqp-02.inet.qwest.net") by vger.kernel.org with SMTP
	id S263861AbTGFWBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 18:01:04 -0400
Date: Sun, 6 Jul 2003 17:12:19 -0700
Message-ID: <001a01c3441c$6fe111a0$6801a8c0@oemcomputer>
From: "Paul Albrecht" <palbrecht@qwest.net>
To: "Nivedita Singhvi" <niv@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, "netdev" <netdev@oss.sgi.com>
References: <3F08858E.8000907@us.ibm.com>
Subject: Re: question about linux tcp request queue handling
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita writes:

>
> Do you have tcp_syncookies on?
>

syncookies = 0.

>
>And are you exceeding the len as configured by tcp_max_syn_backlog?
>

max_syn_backlog = 256.

My server program sets its backlog to one and pauses ninety seconds before
accepting connections.  Within that ninety second interval, I start three
client programs that do an active open to my server.  I expect one of
connections to get discarded when the server's connection backlog limit is
exceeded.




