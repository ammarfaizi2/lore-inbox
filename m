Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSJWFyn>; Wed, 23 Oct 2002 01:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSJWFym>; Wed, 23 Oct 2002 01:54:42 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19460 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262877AbSJWFym>; Wed, 23 Oct 2002 01:54:42 -0400
Message-Id: <200210230555.g9N5tJp00618@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: landley@trommello.org, linux-kernel@vger.kernel.org
Subject: Re: Crunch Time, in 3D!  (2.5 final merge candidate list, v 1.4)
Date: Wed, 23 Oct 2002 08:47:58 -0200
X-Mailer: KMail [version 1.3.2]
Cc: "Guillaume Boissiere" <boissiere@adiglobal.com>
References: <200210221719.41868.landley@trommello.org>
In-Reply-To: <200210221719.41868.landley@trommello.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 6) Page table sharing  (Daniel Phillips, Dave McCracken) (in -mm
> tree) http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35
> (A newer version of which seems to be at:)
> http://lists.insecure.org/lists/linux-kernel/2002/Oct/6446.html
>
> Ed Tomlinson seems to have a show-stopper bug for this one, though:
>
> http://lists.insecure.org/lists/linux-kernel/2002/Oct/7147.html

Is it a major feature? I felt it's an optimization designed to
fix one of rmap VM speed issues (namely, slower fork+exec compared to
2.4 VM). As such it can be accepted after feature freeze as well.
--
vda
