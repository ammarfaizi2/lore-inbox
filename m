Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbTIJAWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 20:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbTIJAWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 20:22:06 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:60434 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265073AbTIJAWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 20:22:04 -0400
Date: Wed, 10 Sep 2003 02:22:02 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: 2.6.0-test5: configcheck results
Message-ID: <20030910022202.B1603@pclin040.win.tue.nl>
References: <20030909100412.A25143@flint.arm.linux.org.uk> <20030909194001.GB3009@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030909194001.GB3009@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Sep 09, 2003 at 09:40:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 09:40:01PM +0200, Sam Ravnborg wrote:
> On Tue, Sep 09, 2003 at 10:04:12AM +0100, Russell King wrote:
> > Hi all,
> > 
> > I just ran make configcheck on 2.6.0-test5 and the results are:
> > 
> >     832 files need linux/config.h but don't actually include it.
> >     689 files which include linux/config.h but don't require the header.
> 
> Randy, you have looked into related perl scripts. Is the result of
> checkconfig.pl reliable?

No, make configcheck is not reliable.
For example, <linux/init.h> includes <linux/config.h>.
But configcheck doesn't notice.

