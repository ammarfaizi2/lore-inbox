Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbSI3UtN>; Mon, 30 Sep 2002 16:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbSI3UtN>; Mon, 30 Sep 2002 16:49:13 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:13760 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S261382AbSI3UtN>;
	Mon, 30 Sep 2002 16:49:13 -0400
Date: Mon, 30 Sep 2002 22:54:37 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Generic HDLC interface continued
Message-ID: <20020930225437.A19967@se1.cogenit.fr>
References: <m3y99nrtsu.fsf@defiant.pm.waw.pl> <20020928202138.A17244@se1.cogenit.fr> <m3smzsnbx9.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3smzsnbx9.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Sun, Sep 29, 2002 at 03:49:22PM +0200
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> :
[...]
> Not exactly. The caller always knows meaning of the returned value
> (or it reports error etc). The caller doesn't just know size of the value
> _in_advance_, as it isn't constant. Still, meaning of the variable portion
> of the data is defined by the constant part.

The caller doesn't know size in advance but he gets 'type' and 'size' at
the same time. Why shouldn't 'size' be deduced from 'type' ?

-- 
Ueimor
