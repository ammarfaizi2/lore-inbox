Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTILRqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTILRqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:46:40 -0400
Received: from pf138.torun.sdi.tpnet.pl ([213.76.207.138]:40205 "EHLO
	centaur.culm.net") by vger.kernel.org with ESMTP id S261782AbTILRqd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:46:33 -0400
From: Witold Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: SII SATA request size limit
Date: Fri, 12 Sep 2003 19:46:31 +0200
User-Agent: KMail/1.5.9
References: <200309112357.41592.eu@marcelopenna.org> <1063363288.5330.1.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063363288.5330.1.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309121946.31810.adasi@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia pi± 12. wrze¶nia 2003 12:41, Alan Cox napisa³:
> On Gwe, 2003-09-12 at 03:57, Marcelo Penna Guerra wrote:
> > In recent kernels, the siimage driver limits the max kb per request size
> > to 15 (7.5kb). As I was having no problems with rqsize of 128 (64kb), I
> > decided to comment out this part of the code and my system is rock solid.
>
> It will depend what disks you have.
>
> > kernels, so people can try to see if it's stable. I really don't beleive
> > that I have such an unique hardware configuration, so this should benefit
> > other people.
>
> You can up it again at runtime.
I've lost some of mails about siimage on LKML, but Im' getting more and more 
confused about 'hangs' probably caused by siimage driver. I was using 15 
rqsize, now 128 - doesn't matter. It happens in random moments - sometimes at 
boot time when drive is fscked, sometimes when I'm trying to copy large 
amount of data and sometimes without any particular reason after several 
hours. I've updated MB (a7n8x deluxe rev 2.0) BIOS but controller (which is 
on-board) bios seems to be untouched (4.1.25 or so ). Is there any controller 
BIOS update which I could miss? what can be other reason? 
-- 
Witold Krêcicki (adasi) adasi [at] culm.net
GPG key: 7AE20871
http://www.culm.net
