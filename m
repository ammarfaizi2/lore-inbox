Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264629AbSJTTNI>; Sun, 20 Oct 2002 15:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSJTTNI>; Sun, 20 Oct 2002 15:13:08 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4042 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264629AbSJTTNI>; Sun, 20 Oct 2002 15:13:08 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210201918.g9KJIFw29036@devserv.devel.redhat.com>
Subject: Re: workaround for Cyrix MediaGX/NSC Geode companion CS5510/5520 PIT latch bug
To: christer@weinigel.se (Christer Weinigel)
Date: Sun, 20 Oct 2002 15:18:15 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), miura@da-cha.org (Hiroshi Miura),
       davej@suse.de, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <878z0shqee.fsf@zoo.weinigel.se> from "Christer Weinigel" at Oct 20, 2002 09:16:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have seen a similar problem with a Geode SC1200 based system which
> basically is a GX1 and a CS5530 integrated on one chip.  I'm starting
> to wonder if the same bug has popped up again in the newer chip.

The lack of delay between the two reads doesnt seem to be a chip bug but
a Linux bug.
