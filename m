Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWJWOIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWJWOIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWJWOIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:08:23 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:25788 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964871AbWJWOIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:08:22 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Move swap allocation routines to swap.c
Date: Mon, 23 Oct 2006 16:07:55 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <1161576964.3466.12.camel@nigel.suspend2.net> <200610231247.09113.rjw@sisk.pl> <1161604186.3315.0.camel@nigel.suspend2.net>
In-Reply-To: <1161604186.3315.0.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231607.56028.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 October 2006 13:49, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2006-10-23 at 12:47 +0200, Rafael J. Wysocki wrote:
> > On Monday, 23 October 2006 06:16, Nigel Cunningham wrote:
> > > Move swap allocation routines from swsusp.c to swap.c, so that all of
> > > the swap related stuff really is in swap.c.
> > 
> > The original idea was to keep that in swsusp.c because it was also used by
> > some code in user.c.
> > 
> > I'd like it to stay as is.
> 
> The other code in swap.c is also used by user.c.

Er, which one?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
