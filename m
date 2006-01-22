Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWAVToW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWAVToW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWAVToW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:44:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61647 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750801AbWAVToW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:44:22 -0500
Subject: Re: [PATCH] add /proc/*/pmap files
From: Arjan van de Ven <arjan@infradead.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <787b0d920601221117l78a92fd1udc8601068dbde42c@mail.gmail.com>
References: <787b0d920601220150n2e34e376i856cc583a372e1f2@mail.gmail.com>
	 <1137940577.3328.14.camel@laptopd505.fenrus.org>
	 <787b0d920601221117l78a92fd1udc8601068dbde42c@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 20:44:19 +0100
Message-Id: <1137959059.3328.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-22 at 14:17 -0500, Albert Cahalan wrote:
> On 1/22/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Sun, 2006-01-22 at 04:50 -0500, Albert Cahalan wrote:
> > > This adds a few things needed by the pmap command.
> > > They show up in /proc/*/pmap files.
> >
> >
> > also since this shows filenames and such, could you make the permissions
> > of the pmap file be 0400 ? (yes I know some others in the same dir
> > aren't 0400 yet, but I hope that that can be changed in the future,
> > adding more of these should be avoided for information-leak/exposure
> > reasons)
> 
> I thought it was the addresses you'd object to.

well both ;)

knowing that you're listening to Mrs Stefani's music rather than
watching her music clips is something you might not want to spread to
other users of your system. Or in other words, open files already
disclose "private" stuff. 

> I notice that Fedora Core 4 shipped with /proc/*/smaps
> files that were readable, but /proc/*/maps files that were
> not readable. (at least, a recent kernel update did)

that'd be a mistake


> As of now, I'm keeping mainstream kernel policy as is.

you're making a NEW file, so there is no "mainstream policy" yet. Please
do it right the first time so that it doesn't have to change later...


