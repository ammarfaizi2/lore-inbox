Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbVKWKwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbVKWKwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 05:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbVKWKwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 05:52:13 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:29398 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1030397AbVKWKwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 05:52:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Date: Wed, 23 Nov 2005 11:53:00 +0100
User-Agent: KMail/1.8.3
References: <87zmoa0yv5.fsf@obelix.mork.no> <200511222315.31033.rjw@sisk.pl> <20051122225120.GI1748@elf.ucw.cz>
In-Reply-To: <20051122225120.GI1748@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511231153.01017.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 22 of November 2005 23:51, Pavel Machek wrote:
> > > Well, I do not think this problem will surface again. It is first
> > > failure in pretty long time. If it happens again, I'll take your
> > > patch.
> > 
> > If so, could you please make it printk() a message after the timeout has
> > passed?  This way the user will know what's going on at least.
> 
> We do have messages there, they even tell you name of process that was
> not stopped. That's enough to debug failure quickly.

The problem is that currently the messages are only printed after the timeout,
so if you puch the timeout to infinity, they won't get printed at all.

Greetings,
Rafael
