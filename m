Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292466AbSCOOLL>; Fri, 15 Mar 2002 09:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292482AbSCOOLB>; Fri, 15 Mar 2002 09:11:01 -0500
Received: from mail.emit.pl.108.205.195.in-addr.arpa ([195.205.108.125]:530
	"EHLO mail.emit.pl") by vger.kernel.org with ESMTP
	id <S292466AbSCOOKz>; Fri, 15 Mar 2002 09:10:55 -0500
Date: Fri, 15 Mar 2002 15:11:27 +0100
From: Ian Carr-de Avelon <avelon@emit.pl>
Message-Id: <200203151411.PAA04407@mail.emit.pl>
Subject: Re: 3com switch with 2.4.17
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Heidl <heidl@zib.de> wrote:
>On Fri, Mar 15, 2002 at 11:54:38AM +0100, Ian Carr-de Avelon wrote:
>> I have a 486 which runs as a router, and I want to change to 2.4. After
>> boot and working out which order the ether cards are now found in, everything
>> is OK except I can't ping PCs connected to a 3com switch, which connects
>> to a ne2k-pci RTL-8029 card in the 486 via a hub. PCs directly connected to
>> the hub ping OK. 
>> Does this ring any bells as to why this could be OK with a 2.2.13 kernel
>> but broken with 2.4.17?
>
>might be related to ECN (just a guess). Have a look at this:
>http://www.kernel.org/pub/linux/docs/lkml/#s14-2
Well that fixed it. Many thanks I'd never have found that.
Yours
Ian

