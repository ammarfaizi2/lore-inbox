Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVBAW0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVBAW0w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVBAW0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:26:52 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:13412 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262143AbVBAWXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:23:19 -0500
Date: Tue, 1 Feb 2005 23:23:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>, Paul Mundt <paul.mundt@nokia.com>
Cc: Paul Mundt <paul.mundt@nokia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SuperHyway bus support
Message-ID: <20050201222327.GA3200@mars.ravnborg.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Paul Mundt <paul.mundt@nokia.com>, linux-kernel@vger.kernel.org
References: <20041027075248.GA26760@pointless.research.nokia.com> <20050107072222.GB24441@kroah.com> <20050107094103.GA7408@pointless.research.nokia.com> <20050107162945.GA19043@pointless.research.nokia.com> <20050112081722.GA2745@kroah.com> <20050112124836.GA9315@pointless.research.nokia.com> <20050201220552.GA13994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201220552.GA13994@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 02:05:52PM -0800, Greg KH wrote:
> >  drivers/sh/Makefile                      |    6 
> >  drivers/sh/superhyway/Makefile           |    7 +
> >  drivers/sh/superhyway/superhyway-sysfs.c |   45 ++++++
> >  drivers/sh/superhyway/superhyway.c       |  201 +++++++++++++++++++++++++++++++
> >  include/linux/superhyway.h               |   79 ++++++++++++
> >  5 files changed, 338 insertions(+)

Why does it need a .h file in include/linux/?
Only use include/linux/* for .h files which is used by other parts of
the kernel.

[I've lost the original mail - so cannot see the actual source].

	Sam
