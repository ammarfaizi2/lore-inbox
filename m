Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbUENWjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUENWjO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 18:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUENWjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 18:39:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:23441 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263079AbUENWjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 18:39:13 -0400
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040514153407.0879b930.akpm@osdl.org>
References: <20040513145640.GA3430@dreamland.darkstar.lan>
	 <1084488901.3021.116.camel@gaston>
	 <20040514164154.GA3852@dreamland.darkstar.lan>
	 <1084571316.31315.35.camel@gaston>  <20040514153407.0879b930.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1084574160.31001.39.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 15 May 2004 08:36:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Can we remove them for now?  People's machines are crashing...

The proper fix is the kmalloc I suppose, but yes, remove them for
now.

Ben.


