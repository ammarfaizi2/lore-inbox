Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWFMUUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWFMUUf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWFMUUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:20:34 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:5598 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932194AbWFMUUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:20:34 -0400
Date: Tue, 13 Jun 2006 22:20:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jason <bofh1234567@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SO_REUSEPORT and multicasting
In-Reply-To: <20060613192420.49742.qmail@web53603.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0606132219420.11918@yvahk01.tjqt.qr>
References: <20060613192420.49742.qmail@web53603.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Does the kernel support SO_REUSEPORT?

IIRC no, *BSD being the only one(s) I know of.

> If so can
>anyone give me some suggestions why my program does
>not work on Linux?  I did a route add -net 224.0.0.0/4
>dev eth0 but that did not do anything.
>
Have you bound to a multicast group in your program?


Jan Engelhardt
-- 
