Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSJAJxF>; Tue, 1 Oct 2002 05:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261544AbSJAJxE>; Tue, 1 Oct 2002 05:53:04 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:24079 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261551AbSJAJxD>; Tue, 1 Oct 2002 05:53:03 -0400
Message-Id: <200210010954.g919s4p24056@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
Date: Tue, 1 Oct 2002 12:48:03 -0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 October 2002 05:32, Linus Torvalds wrote:
> Merges with all the regular suspects - Al's partitioning, Andrew on VM,
> USB, networking, sparc, net drivers. And Ingo has been working on fixing
> up the inevitable details in the thread signal stuff, as well as updating
> the smp-scalable timer code.
>
> And ISDN, kbuild, ARM, uml...
>
> And a small reminder that we're now officially in the last month of
> features, and since I'm going to be away basically the last week of
> October, so I actually personally consider Oct 20th to be the drop-date,
> unless you've got a really good and scary costume.. So don't try to leave
> it to the last day.
>
> [ And if that didn't worry you, the following should: I'm perfectly happy
>   with the kernel, and as such whatever features _you_ think are missing
>   might just not weigh too much with me if you then also make the mistake
>   of trying to leave them for the last crunch. I might just take the last
>   day off too ;]
>
> And if it wasn't clear to the non-2.5-development people out there, yes
> you _should_ also test this code out even before the freeze. The IDE layer
> shouldn't be all that scary any more, and while there are still silly
> things like trivially non-compiling setups etc, it's generally a good idea
> to try things out as widely as possible before it's getting too late to
> complain about things..

I think those people who has two boxes and an eth link can test 2.5 on NFS 
root mode since 2.5 does not contain big changes to NFS code and it's harder 
to corrupt filesystems over NFS ;-). Problems? Just use that Big Red Switch!
(don't forget to write down oops first though ;-)

I personally would do that too, once it would compile for me.
BTW, where's netconsole patches for 2.5, just in case?
--
vda
