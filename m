Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268989AbRG3Pu7>; Mon, 30 Jul 2001 11:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268983AbRG3Put>; Mon, 30 Jul 2001 11:50:49 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:2318 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268989AbRG3Puq>; Mon, 30 Jul 2001 11:50:46 -0400
Message-ID: <3B6583C2.EE0B795C@zip.com.au>
Date: Tue, 31 Jul 2001 01:56:50 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Peter J. Braam" <braam@clusterfilesystem.com>
CC: lkml <linux-kernel@vger.kernel.org>,
        Shirish Phatak <shirish@tacitussystems.com>
Subject: Re: ext3-2.4-0.9.5
In-Reply-To: <3B657AD9.E15B756D@zip.com.au> <MAEOLIJIABPOFFEFBMOKGEHBCDAA.braam@clusterfs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Peter J. Braam" wrote:
> 
> Hi Andrew,
> 
> Boy, you've had quite a weekend again.
> 
> Do you think this includes the fix for Shirish' bug?

Alas, no.  That one is due to the mixed-mode journalling.
The use of `chattr +J' to place a portion of an ordered-mode
fs into full-data journalling.

I'll take a look at that next.  Could you not put the
entire fs into journalled data mode until it's fixed?

-
