Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTIQSqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 14:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbTIQSqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 14:46:44 -0400
Received: from mail.broadpark.no ([217.13.4.2]:45029 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S262609AbTIQSql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 14:46:41 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Changes in siimage driver?
References: <oprvnjyf2oq1sf88@mail.broadpark.no> <1063816835.12648.90.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <oprvnqkoo5q1sf88@mail.broadpark.no>
From: Arve Knudsen <aknuds-1@broadpark.no>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Wed, 17 Sep 2003 20:49:26 +0200
In-Reply-To: <1063816835.12648.90.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Opera7.20/Linux M2 build 463
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Sep 2003 17:40:36 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> 
wrote:

> On Mer, 2003-09-17 at 17:26, Arve Knudsen wrote:
>> X66 etc.) with hdparm, I get ~50MB/S. It's not an ideal solution since 
>> now
>> and then I get a bunch of "disabling irq #18" messages after running
>> hdparm (I think, its part of the startup scripts), and I have to 
>> restart.
>
> That is a bug in the 2.6.0 core still. Just hack out the code which does
> the IRQ disable on too many apparently unidentified interrupts.
Ok, thanks for identifying the source of this. I'm no kernel hacker at 
all, but I'll see what I can find.

>> directories. Am I the only one who's run into any sort of issues with 
>> the
>> updated driver? From what I can see it hasn't been modified in the last
>> revision (test5-bk4), hopefully noone is losing important data because 
>> of
>> this (fortunately I had some recent backups). Anyway, I'd like some
>> feedback on this from those in the know (the performance drop should be
>> fairly easy to verify, unless hdparm is playing tricks on me).
>
> Don't keep important data only on 2.6-test boxes. Its 'test' - it
> shouldnt eat anything but...
Well, I understand that, but the older version of the driver (as of 
test4-mm4) doesn't have these problems (better performance according to 
hdparm, no corruption). The latest changes to the driver seems to have 
introduced problems, or is it just me?

Thanks for the swift reply

Arve Knudsen
