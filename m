Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317549AbSGJQvc>; Wed, 10 Jul 2002 12:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317546AbSGJQvb>; Wed, 10 Jul 2002 12:51:31 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18446 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317549AbSGJQv0>; Wed, 10 Jul 2002 12:51:26 -0400
Subject: Re: [STATUS 2.5]  July 10, 2002
To: thunder@ngforever.de (Thunder from the hill)
Date: Wed, 10 Jul 2002 18:17:13 +0100 (BST)
Cc: bunk@fs.tum.de (Adrian Bunk),
       boissiere@adiglobal.com (Guillaume Boissiere),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207101027380.5067-100000@hawkeye.luckynet.adm> from "Thunder from the hill" at Jul 10, 2002 10:31:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SL5W-0007Ra-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >    - Better event logging for enterprise systems
> Linus was scared we could break old syslog parsers.

This is still in discussion. The real issue is not breaking syslog parsers
(in fact its a way to make sure they dont break in future) but to get 

-	Accurate reporting
-	Error classifications
-	Error manuals
-	Translations
etc

done in a way that doesnt make the kernel ugly. Thats non trivial. I need
to schedule a discussion with some IBM folks about part of this 


Alan
