Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbRCWMmZ>; Fri, 23 Mar 2001 07:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130686AbRCWMmP>; Fri, 23 Mar 2001 07:42:15 -0500
Received: from [32.97.166.32] ([32.97.166.32]:14841 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S130685AbRCWMmE>;
	Fri, 23 Mar 2001 07:42:04 -0500
Message-Id: <m14fqYt-001PKeC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: kuznet@ms2.inr.ac.ru
Cc: rmk@arm.linux.org.uk (Russell King), crosser@average.ORG,
        linux-kernel@vger.kernel.org
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18 
In-Reply-To: Your message of "Mon, 19 Mar 2001 21:56:50 +0300."
             <200103191856.VAA01054@ms2.inr.ac.ru> 
Date: Thu, 22 Mar 2001 08:54:31 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200103191856.VAA01054@ms2.inr.ac.ru> you write:
> If I understood Andrew's mail correctly, rsync freezes when 
> large amount of errors happen. Particularly, here ssh always freezes

Known hard-to-fix bug in rsync; too many errors in the pipe, and it
locks up.

Rusty.
--
Premature optmztion is rt of all evl. --DK
