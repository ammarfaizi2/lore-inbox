Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTE3Jey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 05:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTE3Jey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 05:34:54 -0400
Received: from verein.lst.de ([212.34.189.10]:9447 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263493AbTE3Jex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 05:34:53 -0400
Date: Fri, 30 May 2003 11:48:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: "ismail (cartman) donmez" <kde@myrealbox.com>
Cc: "H. J. Lu" <hjl@lucon.org>, linux kernel <linux-kernel@vger.kernel.org>,
       GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Recent binutils releases and linux kernel 2.5.69+
Message-ID: <20030530094805.GA30793@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	"ismail (cartman) donmez" <kde@myrealbox.com>,
	"H. J. Lu" <hjl@lucon.org>,
	linux kernel <linux-kernel@vger.kernel.org>,
	GNU C Library <libc-alpha@sources.redhat.com>
References: <20030529074448.A29931@lucon.org> <20030529095940.B31904@lucon.org> <20030530084824.GA29758@lst.de> <200305301245.26808.kde@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305301245.26808.kde@myrealbox.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 12:45:26PM +0300, ismail (cartman) donmez wrote:
> On Friday 30 May 2003 11:48, Christoph Hellwig wrote:
> > I know. and <linux/sysctl.h> is a kernel header libc shouldn't include.
> > So you want to do something to <sys/sysctl.h>, namely get rid of it's
> > depency on kernel headers.
> Wouldn't this result in glibc-kernel inconsistency in headers?

How so?  If the sysctl values change you're screwed anyway.

