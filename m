Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268237AbUIBK4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268237AbUIBK4s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268233AbUIBKyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:54:47 -0400
Received: from the-village.bc.nu ([81.2.110.252]:58509 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268132AbUIBKyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:54:00 -0400
Subject: Re: silent semantic changes with reiser4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Tonnerre <tonnerre@thundrix.ch>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, spam@tnonline.net,
       akpm@osdl.org, wichert@wiggy.net, jra@samba.org, torvalds@osdl.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com, vonbrand@inf.utfsm.cl
In-Reply-To: <20040901201608.GD31934@mail.shareable.org>
References: <20040829191044.GA10090@thundrix.ch>
	 <3247172997-BeMail@cr593174-a> <20040831081528.GA14371@thundrix.ch>
	 <20040901201608.GD31934@mail.shareable.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094118649.4847.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 10:50:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 21:16, Jamie Lokier wrote:
> (For example, if I edit an HTML file which is encoded in iso-8859-1,
> change it to utf-8 and indicate that in a META element, and save it
> under the same name, the full content-type should change from
> "text/html; charset=iso-8859-1" to "text/html; charset=utf-8".)
> 
> I don't see how you can do that without kernel support.
> 
> Don't say dnotify or inotify, because neither would work.

inotify done right is useful here as well as in a lot of other desktop
cases where dnotify doesn't really scale. Its enough to let me

	- Find the new file
	- Virus scan it
	- Classify its possible type heirarchies
	- Index it

Alan

