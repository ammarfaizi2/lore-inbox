Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbSI3MvG>; Mon, 30 Sep 2002 08:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262047AbSI3MvF>; Mon, 30 Sep 2002 08:51:05 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:61434 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262046AbSI3MvF>; Mon, 30 Sep 2002 08:51:05 -0400
Subject: Re: [PATCH] 2.5.39 - make MCE options arch dependent
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Phil Oester <kernel@theoesters.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020929161206.A14962@ns1.theoesters.com>
References: <20020929161206.A14962@ns1.theoesters.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 14:03:06 +0100
Message-Id: <1033390986.16337.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 00:12, Phil Oester wrote:
> No need to see P4 or Athlon options if you don't have one..

This makes little sense. The P4 and K7 MCE handling can be built into
any kernel tree and will correctly work. That means you can build things
into a generic kernel not just a per processor kernel, which for any
number of systems becomes unmanagable


