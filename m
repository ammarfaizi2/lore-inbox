Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWDZUlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWDZUlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWDZUlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:41:55 -0400
Received: from xenotime.net ([66.160.160.81]:25009 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932078AbWDZUly convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:41:54 -0400
Date: Wed, 26 Apr 2006 13:44:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: C++ pushback
Message-Id: <20060426134419.a0515561.rdunlap@xenotime.net>
In-Reply-To: <1146082192.11123.4.camel@bip.parateam.prv>
References: <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com>
	<1146082192.11123.4.camel@bip.parateam.prv>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006 22:09:51 +0200 Xavier Bestel wrote:

> Le mercredi 26 avril 2006 à 12:25 -0700, David Schwartz a écrit :
> 
> > 	C++ has how many additional reserved words? I believe the list is delete,
> > friend, private, protected, public, template, throw, try, and catch.
> 
> You forgot namespace, mutable, new, class, const_cast, dynamic_cast,
> static_cast, reinterpret_cast, explicit, true, false, operator, typeid,
> typename and virtual. Maybe I forgot some (interface ?). Probably some
> new ones will appear.

I did a sparse patch to check for all(?) of those once (with Linus's
help).  I don't know if it still applies or not...

It's at http://www.xenotime.net/linux/sparse/check_keywords_v7.patch
(You'll also need the other patch there; they got a bit comingled:
http://www.xenotime.net/linux/sparse/check_sizeof_v7.patch)

---
~Randy
