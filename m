Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTF0Npp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 09:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTF0Npp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 09:45:45 -0400
Received: from mail.atr.bydgoszcz.pl ([212.122.192.35]:49609 "EHLO
	mail.atr.bydgoszcz.pl") by vger.kernel.org with ESMTP
	id S264277AbTF0Npn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 09:45:43 -0400
From: "adamski" <adam_lista_linux@poczta.onet.pl>
To: "Robert Olsson" <Robert.Olsson@data.slu.se>,
       "adamski" <adam_lista_linux@poczta.onet.pl>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: RE: How to do kernel packet forwarding performance analysys - please comment on my method 
Date: Fri, 27 Jun 2003 15:59:21 +0200
Message-ID: <GMEGLMHAELFDACHHIEPIGECECFAA.adam_lista_linux@poczta.onet.pl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <16124.17582.796111.577015@robur.slu.se>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4925.2800
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > i would like to start two flows through linux router: PHB EF and BE PHB..
 > like voip and ftp or so...
 >
 > than i want to analyse what exactly happens ... since my theoretical
 > analysys show delays (or latencies - from packet entering the NIC to
going
 > out of the outgoing interface) of hundereds of usec (~200us) while
 > experiments shows 5-10ms !!!!! with CBQ (configured like CBWFQ and LLQ)

 Seems you have to add your own hooks for this and I guess you've seen
 CONFIG_NET_PROFILE which does accurate measurements for network related
 operations. It was long time since I used though...


.... could you please say something about CONFIG_NET_PROFILE and hooks you
have mentioned????

are there any documents ... related with hooks and CONFIG_NET_PROFILE


best regards

adam

