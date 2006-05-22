Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWEVOiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWEVOiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWEVOiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:38:12 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:26831 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1750871AbWEVOiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:38:12 -0400
Subject: Re: [PATCH] Add user taint flag
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1148308548.17376.44.camel@localhost.localdomain>
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
	 <1148307276.3902.71.camel@laptopd505.fenrus.org>
	 <1148308548.17376.44.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 22 May 2006 16:37:54 +0200
Message-Id: <1148308674.3902.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-22 at 15:35 +0100, Alan Cox wrote:
> On Llu, 2006-05-22 at 16:14 +0200, Arjan van de Ven wrote:
> > we should then patch the /dev/mem driver or something to set this :)
> > (well and possibly give it an exception for now for PCI space until the
> > X people fix their stuff to use the proper sysfs stuff)
> 
> /dev/mem is used for all sorts of sane things including DMIdecode.
> Tainting on it isn't terribly useful.

I meant taint-on-writable/write, dmi and others map it read only which
is obviously different


