Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUBQVkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUBQVhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:37:34 -0500
Received: from mail.shareable.org ([81.29.64.88]:10885 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266637AbUBQVhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:37:18 -0500
Date: Tue, 17 Feb 2004 21:37:14 +0000
From: Jamie Lokier <jamie@shareable.org>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
Message-ID: <20040217213714.GI24311@mail.shareable.org>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr> <20040216062152.GB5192@pegasys.ws> <20040216155534.GA17323@mail.shareable.org> <20040217064755.GC9466@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217064755.GC9466@pegasys.ws>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
> Your concrete example is a good one.  Where did that
> filename come from?  It would seem to have come from the
> keyboard via a tty (or simulator) which also had to display
> it.  I'd say this is an argument for the terminal to display
> UTF-8 and convert intput into UTF-8.  That is something that
> seems to be not consistantly done as yet.  Ultimately it
> seems to be a responsiblity of the user interface, whether
> tty or GUI.  Until that happens the shells might be able to
> fill the gap, however poorly.

Many terminals will not ever display UTF-8.  Think: all the serial terminals.

This is why I think "stty utf8" or something along those lines would
be useful.  The terminal itself doesn't have to talk UTF-8; however,
the applications talking with /dev/tty would always see UTF-8.

That seems to solve most of the practical user interface problems of
the command line, in one single clean place.

-- Jamie
