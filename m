Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262259AbSIZJaz>; Thu, 26 Sep 2002 05:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262261AbSIZJaz>; Thu, 26 Sep 2002 05:30:55 -0400
Received: from [217.167.51.129] ([217.167.51.129]:24319 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S262259AbSIZJaz>;
	Thu, 26 Sep 2002 05:30:55 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>, <zaitcev@redhat.com>
Cc: <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>, <axboe@suse.de>,
       <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] fix ide-iops for big endian archs
Date: Thu, 26 Sep 2002 00:49:08 +0200
Message-Id: <20020925224908.5805@192.168.4.1>
In-Reply-To: <20020925.125734.32605968.davem@redhat.com>
References: <20020925.125734.32605968.davem@redhat.com>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   IDE uses ide_insw instead of plain insw specifically to
>   resolve this kind of issue, and you are trying to defeat
>   the mechanism designed to help you. I smell a fish here.
>
>They're trying to abstract out as much as possible in 2.5.x, maybe a
>bit too much :-)

Well, no, we are changing the abstraction but didn't quite yet
remove rests of the old one ;)

Ben.


