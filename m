Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266380AbUGJUM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266380AbUGJUM7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 16:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266386AbUGJUM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 16:12:59 -0400
Received: from iris-63.mc.com ([63.96.239.5]:64446 "EHLO mc.com")
	by vger.kernel.org with ESMTP id S266380AbUGJUMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 16:12:47 -0400
Subject: Re: [PATCH] Fix building on Solaris (and don't break Cygwin)
From: Jean-Christophe Dubois <jdubois@mc.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jean-Christophe Dubois <jdubois@mc.com>
In-Reply-To: <20040709212004.GA6203@infradead.org>
References: <20040709210011.GG28002@smtp.west.cox.net>
	 <20040709211605.GA6126@infradead.org>
	 <20040709211853.GH28002@smtp.west.cox.net>
	 <20040709212004.GA6203@infradead.org>
Content-Type: text/plain
Message-Id: <1089490341.25093.151.camel@lancelot.dubois.etowns.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 10 Jul 2004 22:12:22 +0200
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2004 20:12:24.0722 (UTC) FILETIME=[3713EF20:01C466BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

On Fri, 2004-07-09 at 23:20, Christoph Hellwig wrote:
> On Fri, Jul 09, 2004 at 02:18:53PM -0700, Tom Rini wrote:
> > I forgot to CC Jean on this, but that's not exactly a nice option.  In
> > fact, it'd be fine to just switch to <inttypes.h>, afaics, except that
> > cygwin doesn't have that.
> 
> Tell him to build on Linux, we don't support legacy OSes ;-)

Although I am certainly hopeful I will be able to use Linux end to end
in a not too distant future :), I have to work with what I am given
today. And maybe I am not the only one in this situation ...

Please be a bit compassionate with the poor souls out there that have to
cope with Legacy OSes as build systems and/or configuration management
systems :(

Also please note that 2.4 uses to build OK on Solaris. The actual 2.6
situation is a little step-back in this matter.

JC

