Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbUCKPLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUCKPLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:11:31 -0500
Received: from furon.ujf-grenoble.fr ([152.77.2.202]:16558 "EHLO
	furon.ujf-grenoble.fr") by vger.kernel.org with ESMTP
	id S261370AbUCKPLG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:11:06 -0500
From: Mickael Marchand <marchand@kde.org>
To: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.4-mm1
Date: Thu, 11 Mar 2004 16:10:02 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, dm@uk.sistina.com
References: <1ysXv-wm-11@gated-at.bofh.it> <200403111445.35075.marchand@kde.org> <20040311144829.GA22284@colin2.muc.de>
In-Reply-To: <20040311144829.GA22284@colin2.muc.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403111610.02128.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just the ioctl cmd failed I reported in my first mail.
then dmsetup just stops...

Cheers,
Mik

Le jeudi 11 Mars 2004 15:48, Andi Kleen a écrit :
> > hmm right now, dm/lvm absolutely does not work on amd64/32 bits. all
> > ioctls calls are failling...
>
> With no messages in the log?
>
> Maybe they have broken data structures again, most likely
> because of different long long alignment. A lot of people
> who attempt to design data structures that don't need translation
> get that wrong unfortunately.
>
> Emulating that stuff would be hard unfortunately because it has an rather
> over complicated ioctl structure that would be hard to write sane
> emulation code for.
>
> Complain to the DM maintainers.
already did.


