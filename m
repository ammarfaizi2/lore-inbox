Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSGCWWG>; Wed, 3 Jul 2002 18:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317303AbSGCWWF>; Wed, 3 Jul 2002 18:22:05 -0400
Received: from [213.4.129.129] ([213.4.129.129]:27975 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id <S317302AbSGCWWE>;
	Wed, 3 Jul 2002 18:22:04 -0400
Date: Thu, 4 Jul 2002 00:26:36 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Ryan Anderson <ryan@michonline.com>
Cc: oliver@neukum.name, trini@kernel.crashing.org, corbet@lwn.net,
       linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-Id: <20020704002636.59071208.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.10.10207021746570.579-100000@mythical.michonline.com>
References: <200207022010.50572.oliver@neukum.name>
	<Pine.LNX.4.10.10207021746570.579-100000@mythical.michonline.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002 17:50:19 -0400 (EDT)
Ryan Anderson <ryan@michonline.com> escribió:

> In a single processor, no preempt kernel, there is no race.
> Turn on SMP or preempt and there is one.

So we _can't_ talk about remove module removal, but _disabling_ module
removal in the worst case.

Because if the above is correct, single processors without preempt works
well and can use module removal safely...
