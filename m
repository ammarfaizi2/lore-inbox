Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSJAMvm>; Tue, 1 Oct 2002 08:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbSJAMvm>; Tue, 1 Oct 2002 08:51:42 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:14746 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261599AbSJAMvl>;
	Tue, 1 Oct 2002 08:51:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tabris <tabris@tabris.net>
Subject: Re: opps 2.4.20-pre5-ac2
Date: Tue, 1 Oct 2002 14:56:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Lawrence Walton <lawrence@the-penguin.otak.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <20020908203126.GA11475@the-penguin.otak.com> <200209081753.14660.tabris@tabris.net> <1031605767.29793.52.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1031605767.29793.52.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wMZP-0005tQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 23:09, Alan Cox wrote:
> On Sun, 2002-09-08 at 22:53, Tabris wrote:
> > This is an interaction of the rmap vm patch (included in -ac) and the nVidia 
> > binary driver. I have run into this myself, tho it doesn't usually cause a 
> 
> Only he isnt using the Nvidia driver. Somehow he got a page that should
> not have been blown away because someone still had maps to it.

This might be the lru race, see "[CFT] [PATCH] LRU race fix"

-- 
Daniel
