Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267884AbTAHTlx>; Wed, 8 Jan 2003 14:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267885AbTAHTlx>; Wed, 8 Jan 2003 14:41:53 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:31493 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S267884AbTAHTlv>;
	Wed, 8 Jan 2003 14:41:51 -0500
Date: Wed, 8 Jan 2003 14:50:29 -0500
Message-Id: <200301081950.h08JoTr15738@buggy.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, nick@snowman.net
Subject: Re: 3CR990 question (Nearly unrelated to iSCSI)
In-Reply-To: <20030108020033.GA6579@gtf.org>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2003 21:00:33 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> On Tue, Jan 07, 2003 at 07:56:37PM -0500, nick@snowman.net wrote:
>> On Wed, 8 Jan 2003, Andrew McGregor wrote:
>> > > AH permits multiple digests, they also happen to correspond to the
>> > > hardware accelerated ones on things like the 3c990...
>> Speaking of which, did this driver which was mentioned ever occur?
> 
> Two did, actually :)

Actually, the 3Com driver I cleaned up does not have support for the 
hardware crypto chip. Maybe the other driver you were referring to 
supports it?

> I hope we will see it appear in a kernel RSN

Indeed. :) That damn legalese in 3Com's license...

In the meantime, I can separately distribute it to people who need it:
<http://www.badula.org/3c990/>.

The latest version (LK1.0.1) properly supports big-endian architectures,
tested on a sparc64. 

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
