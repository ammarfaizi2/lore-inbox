Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266712AbTA0Nlp>; Mon, 27 Jan 2003 08:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTA0Nlp>; Mon, 27 Jan 2003 08:41:45 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:31628 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S266712AbTA0Nlp> convert rfc822-to-8bit;
	Mon, 27 Jan 2003 08:41:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Jens Axboe <axboe@suse.de>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ATA TCQ  problems in 2.5.59
Date: Mon, 27 Jan 2003 14:50:59 +0100
User-Agent: KMail/1.4.1
References: <200301261605.00539.roy@karlsbakk.net> <Pine.LNX.4.44.0301261116390.16853-100000@coffee.psychology.mcmaster.ca> <20030126162120.GO889@suse.de>
In-Reply-To: <20030126162120.GO889@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301271450.59304.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > but it's a flag, not a count.  use CONFIG_BLK_DEV_IDE_TCQ_DEPTH
> > if you want something other than the default depth of 1.
>
> It's a flag, correct. The default depth is 32 though, not 1. And with
> newer hdparms you can use -Q to set/query the tag depth of the drive. Be
> careful with that though, it's not too well tested. IDE TCQ in 2.5 needs
> a bit of work, I hope to do so soonish...

but shouldn't the 'echo using_tcq:32' be equivilent of hdparm -Q?

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

