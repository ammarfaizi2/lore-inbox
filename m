Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUAQXSt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 18:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265912AbUAQXSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 18:18:49 -0500
Received: from pcp04149116pcs.sanarb01.mi.comcast.net ([68.40.238.157]:28800
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S262130AbUAQXSs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 18:18:48 -0500
Subject: Re: [RFC] kill sleep_on
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>
References: <40098251.2040009@colorfullife.com>
	 <1074367701.9965.2.camel@imladris.demon.co.uk>
	 <20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074381523.1536.17.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 17 Jan 2004 18:18:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 17/01/2004 klokka 15:10, skreiv
viro@parcelfarce.linux.theplanet.co.uk:

> We need to remove racy uses anyway - that can't wait for 2.7.  And I really
> wonder if there will be anything left after that - right now only reiserfs
> uses look like something that might be not immediately broken.

rpciod is quite safe as it is. I'm not against changing it, but it's not
a high priority patch as far as I'm concerned.

Cheers,
  Trond
