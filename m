Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267604AbUHWJTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267604AbUHWJTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 05:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267613AbUHWJTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 05:19:21 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:37835 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267604AbUHWJTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 05:19:16 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 23 Aug 2004 11:18:15 +0200
To: tonnerre@thundrix.ch, schilling@fokus.fraunhofer.de,
       linux-kernel@vger.kernel.org
Subject: Re: GNU make alleged of "bug" (was: PATCH: cdrecord: avoiding scsi 
 device numbering for ide devices)
Message-ID: <4129B657.nailA1F3SQJKJ@burner>
References: <200408191600.i7JG0Sq25765@tag.witbe.net>
 <200408191341.07380.gene.heskett@verizon.net>
 <20040819194724.GA10515@merlin.emma.line.org>
 <20040819220553.GC7440@mars.ravnborg.org>
 <20040819205301.GA12251@merlin.emma.line.org>
 <20040820161524.GF16660@thundrix.ch>
In-Reply-To: <20040820161524.GF16660@thundrix.ch>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Tonnerre <tonnerre@thundrix.ch> wrote:


>On Thu, Aug 19, 2004 at 10:53:01PM +0200, Matthias Andree wrote:
>> include without leading "-" is fine. BSD make doesn't understand either
>> form.

>They got .include IIRC

They document .include but they also implement include.

BTW: For many years, the main problem with BSD make has been that it did not
implement pattern matching macro expansions (introduced ~ 1986 by Sun) correctly.
This year, I did fix this together with BSD people.

Unfortunately, later it turned out that BSD make handles path names to files
completely different from other make files.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
