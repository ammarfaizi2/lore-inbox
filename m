Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270882AbTHFT3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270925AbTHFT3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:29:16 -0400
Received: from guri.is.kpn.be ([193.74.71.22]:16302 "EHLO guri.is.kpn.be")
	by vger.kernel.org with ESMTP id S270882AbTHFT3O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:29:14 -0400
From: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
To: Michael Buesch <fsdeveloper@yahoo.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6] system is very slow during disk access
Date: Wed, 6 Aug 2003 21:29:26 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org
References: <200308062052.10752.fsdeveloper@yahoo.de>
In-Reply-To: <200308062052.10752.fsdeveloper@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308062129.26371.frank.vandamme@student.kuleuven.ac.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 August 2003 20:51, Michael Buesch wrote:
> Hi.
>
> I have massive problems with linux-2.6.0-test2.
> When some process writes something to disk, it's very hard
> to go on working with the system.
>
> Some test-szenario:
> $ dd if=/dev/zero of=./test.file
>
> While dd is running, xmms skips playing every now and then
> and the mouse is near to be unusable. The Mouse-cursor
> behaves some kind of very lazy and some times it jumps
> from one point on the display to another.
> When I stop disk-access, it works again quite fine.
>
> Would be cool, if you could give me some point to start
> for tracking this down.
>
> Please CC me, as I'm not subscribed to linux-ide. Thanks.

Maybe you just didn't enable DMA on them. Use hdparm -v /dev/foo to find out. 

-- 
Frank Van Damme    http://www.openstandaarden.be 
~~~~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Je pense, donc je suis breveté."

