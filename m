Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbTFGLHm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 07:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTFGLHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 07:07:42 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:12689 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262976AbTFGLHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 07:07:41 -0400
Message-Id: <200306071121.h57BL4sG006740@ginger.cmf.nrl.navy.mil>
To: James Stevenson <james@stev.org>
cc: Werner Almesberger <wa@almesberger.net>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Sat, 07 Jun 2003 12:19:40 BST."
             <Pine.LNX.4.44.0306071214110.19033-100000@god.stev.org> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Sat, 07 Jun 2003 07:19:15 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0306071214110.19033-100000@god.stev.org>,James Steven
son writes:
>Think of a latop with a normall ethernet card in it.
>When you unplug the cable it wont disconnect all the tcp
>connection on the interface so that you could re route everything though
>a wireless card.

if i have a single interface and i physically remove it (not just unplug
the cable)  i would be willing to accept that certain tcp connections are
going to die.  particularly tcp which might be using keep alives.
