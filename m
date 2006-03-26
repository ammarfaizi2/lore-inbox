Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWCZAkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWCZAkS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 19:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWCZAkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 19:40:18 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:60330 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932072AbWCZAkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 19:40:16 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] swsusp: finally solve mysqld problem
Date: Sun, 26 Mar 2006 01:38:47 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
References: <200602051321.55519.rjw@sisk.pl> <20060325183817.GM4053@stusta.de>
In-Reply-To: <20060325183817.GM4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603260138.47605.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 25 March 2006 19:38, Adrian Bunk wrote:
> On Sun, Feb 05, 2006 at 01:21:54PM +0100, Rafael J. Wysocki wrote:
> 
> > Hi,
> 
> Hi Rafael,
> 
> > This patch from Pavel moves userland freeze signals handling into
> > more logical place.  It now hits even with mysqld running.
> >...
> 
> I've seen this patch has been included in Linus' tree.
> 
> What exactly was this "mysqld problem" problem, and more specifically, 
> is this patch 2.6.16.2 material?

I don't think it's that urgent, but actually Pavel knows the details (test case
etc.).  IIRC there was/is a problem with freezing mysqld due to the
way in which the userland freeze signals are handled without this patch.
Still mysqld is the only known (to me) application affected.

Greetings,
Rafael
