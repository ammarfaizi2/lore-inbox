Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277954AbRJWQiR>; Tue, 23 Oct 2001 12:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277966AbRJWQiI>; Tue, 23 Oct 2001 12:38:08 -0400
Received: from imo-r02.mx.aol.com ([152.163.225.98]:54516 "EHLO
	imo-r02.mx.aol.com") by vger.kernel.org with ESMTP
	id <S277954AbRJWQhz>; Tue, 23 Oct 2001 12:37:55 -0400
From: Telford002@aol.com
Message-ID: <163.2c1a396.2906f6e8@aol.com>
Date: Tue, 23 Oct 2001 12:38:00 EDT
Subject: Re: (WAN) network device status
To: khc@pm.waw.pl, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 5.0 for Windows sub 139
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a message dated 10/23/01 1:59:03 AM Eastern Daylight Time, khc@pm.waw.pl 
writes:

> I remember a discussion about net_dev->flags and carrier loss etc
>  detection. Did the things change? I mean, do we currently have a way
>  for network device driver to report (to the rest of kernel, to the
>  userland) that the link is down? It would include DCD (carrier) loss,
>  Ethernet link down, IrDA/USB disconnects etc.
>  
>  I think the kernel should deactivate respective routing table entries
>  as well when a link goes down.

Not if the link can be redialed or reconnected implicitly or on-demand
in some way.

Joachim Martillo
