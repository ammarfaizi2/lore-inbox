Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261532AbTCKROL>; Tue, 11 Mar 2003 12:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261536AbTCKROL>; Tue, 11 Mar 2003 12:14:11 -0500
Received: from mail.ithnet.com ([217.64.64.8]:52487 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261532AbTCKROK>;
	Tue, 11 Mar 2003 12:14:10 -0500
Date: Tue, 11 Mar 2003 18:24:26 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Message-Id: <20030311182426.561df21e.skraw@ithnet.com>
In-Reply-To: <20030228162841.17ac0092.skraw@ithnet.com>
References: <20030227221017.4291c1f6.skraw@ithnet.com>
	<20030228162841.17ac0092.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

again, news on this topic. Today I plugged in an additional:

01:03.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev
01)

and connected my ATAPI cdwriter to it. And _now_ everything works! ide-scsi is
just fine, I can mount CDs again. So I state that the ide-driver for 

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)

is in fact broken, at least regarding use of ide-scsi. If anyone has patches or
the like, please submit, I can test.
I tested all available -ac and they all do not work. 2.4.20 does not work
either.

-- 
Regards,
Stephan
