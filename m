Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSGOPIP>; Mon, 15 Jul 2002 11:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSGOPIO>; Mon, 15 Jul 2002 11:08:14 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:24764 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S315178AbSGOPIO>; Mon, 15 Jul 2002 11:08:14 -0400
Date: Mon, 15 Jul 2002 17:08:52 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207151508.g6FF8qJG020820@burner.fokus.gmd.de>
To: riel@conectiva.com.br, schilling@fokus.gmd.de
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Rik van Riel <riel@conectiva.com.br>
>On Mon, 15 Jul 2002, Joerg Schilling wrote:

>> I would be happy to hear about concepts. Currently it looks as if at
>> least some people like to keep everything as it is. This is not a
>> conceptional OS but a grown structure. If you like to keep code
>> maintainable for a long time, you need to clean up the thicket from time
>> to time.

>I couldn't agree more.  Now, why do you oppose cleaning up
>the "use scsi as everyone's mid layer" hack and putting a
>better generic abstraction in place ?

I never said this.

I would like to see a integrated aproach where the mid level prevents something
like ide-cd to access ATAPI drives. In this case, there is a unique address 
space and generic SCSI transport systems like libscg will be able to work
in a way that is easy to understand by outsiders and does not force me to add
one workaround after the other.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
