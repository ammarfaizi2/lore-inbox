Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267932AbTBEMMM>; Wed, 5 Feb 2003 07:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267934AbTBEMML>; Wed, 5 Feb 2003 07:12:11 -0500
Received: from [217.167.51.129] ([217.167.51.129]:59385 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267932AbTBEMMJ>;
	Wed, 5 Feb 2003 07:12:09 -0500
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030205123951.54207275.skraw@ithnet.com>
References: <20030202161837.010bed14.skraw@ithnet.com>
	 <3E3D4C08.2030300@pobox.com> <20030202185205.261a45ce.skraw@ithnet.com>
	 <3E3D6367.9090907@pobox.com> <20030205104845.17a0553c.skraw@ithnet.com>
	 <1044443761.685.44.camel@zion.wanadoo.fr>
	 <20030205123951.54207275.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044447738.685.113.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 Feb 2003 13:22:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have to give a short note on this one:
> indeed is the system currently running with a single CPU, _but_ since it is a
> dual-mb the kernel is already compiled for SMP. It is started with "nosmp"
> option though. I wanted to mention this not knowing if it is important for the
> codepath.

Shouldn be an issue. I suppose you don't use fancy stuff like preempt or
IDE taskfile IO, right ?

Ben.

