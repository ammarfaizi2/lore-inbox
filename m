Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSKMQyH>; Wed, 13 Nov 2002 11:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSKMQyH>; Wed, 13 Nov 2002 11:54:07 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:896 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S262208AbSKMQyH>; Wed, 13 Nov 2002 11:54:07 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Nivedita Singhvi'" <niv@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: tcp_v4_get_port?
Date: Wed, 13 Nov 2002 18:04:09 +0100
Message-ID: <005b01c28b36$af601640$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <Pine.LNX.4.44.0211121431500.18229-100000@w-nivedita.beaverton.ibm.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Am I right that in net/ipv4/tcp_ipv4.c in function "tcp_v4_get_port" the
> portnumber for a new connection is generated? Because fiddling with that
> code seems to have no effect on the portnumbers generated for new
> connections.
NS> What change are you making and which kernel are you making it in?

Kernel 2.4.19
Changes like; have it not starting to use ports from 1024 up, but
rather from 32768 down to 1024 (and then from 65535 down again).

