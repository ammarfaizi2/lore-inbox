Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSGDDuf>; Wed, 3 Jul 2002 23:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317327AbSGDDue>; Wed, 3 Jul 2002 23:50:34 -0400
Received: from ns.suse.de ([213.95.15.193]:2321 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317326AbSGDDud>;
	Wed, 3 Jul 2002 23:50:33 -0400
To: gphat@cafes.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large numbers of TCP resets
References: <20020703201553.DE9FD68CB5EA@mail.cafes.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Jul 2002 05:53:04 +0200
In-Reply-To: gphat@cafes.net's message of "3 Jul 2002 22:23:48 +0200"
Message-ID: <p73ofdow3mn.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gphat@cafes.net writes:

>     111 bad segments received.
>     1003306 resets sent

Linux 2.4 sends a reset when the application closes the socket before all
already arrived  data is read. That could be a likely cause.

-Andi
