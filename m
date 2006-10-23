Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWJWXMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWJWXMA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 19:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWJWXMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 19:12:00 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:33976 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932368AbWJWXMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 19:12:00 -0400
Subject: Re: [PATCH] Move swap allocation routines to swap.c
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200610231607.56028.rjw@sisk.pl>
References: <1161576964.3466.12.camel@nigel.suspend2.net>
	 <200610231247.09113.rjw@sisk.pl>
	 <1161604186.3315.0.camel@nigel.suspend2.net>
	 <200610231607.56028.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 09:11:56 +1000
Message-Id: <1161645116.7033.29.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-10-23 at 16:07 +0200, Rafael J. Wysocki wrote:
> On Monday, 23 October 2006 13:49, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Mon, 2006-10-23 at 12:47 +0200, Rafael J. Wysocki wrote:
> > > On Monday, 23 October 2006 06:16, Nigel Cunningham wrote:
> > > > Move swap allocation routines from swsusp.c to swap.c, so that all of
> > > > the swap related stuff really is in swap.c.
> > > 
> > > The original idea was to keep that in swsusp.c because it was also used by
> > > some code in user.c.
> > > 
> > > I'd like it to stay as is.
> > 
> > The other code in swap.c is also used by user.c.
> 
> Er, which one?

(Looks more)... ah. Maybe I'm confused. I'm still getting to grips with
your code and it's complicated :)

Regards,

Nigel

