Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319247AbSHNJRf>; Wed, 14 Aug 2002 05:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319248AbSHNJRf>; Wed, 14 Aug 2002 05:17:35 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:9485 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S319247AbSHNJRe>; Wed, 14 Aug 2002 05:17:34 -0400
Subject: Re: parport_serial / serial init order wrong?
In-Reply-To: <20020814091439.GN2218@redhat.com>
To: Tim Waugh <twaugh@redhat.com>
Date: Wed, 14 Aug 2002 11:21:22 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17euLC-0000Ft-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What are the bad effects of having rs_init called twice during
> boot-up?

On the second call, it returns immediately because serial_initalized
is set.  Or am I missing something here?

Marek

