Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUFSEMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUFSEMk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 00:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbUFSEMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 00:12:40 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:47626 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265808AbUFSEMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 00:12:39 -0400
Date: Sat, 19 Jun 2004 06:07:17 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] save kernel version in .config file
Message-ID: <20040619040717.GA32209@alpha.home.local>
References: <20040617220651.0ceafa91.rddunlap@osdl.org> <20040618053455.GF29808@alpha.home.local> <20040618205602.GC4441@mars.ravnborg.org> <20040618150535.6a421bdb.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618150535.6a421bdb.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 03:05:35PM -0700, Randy.Dunlap wrote:
 
> OK, I've added date, based on Sam's comments, but someone tell me,
> when/why does filesystem-timestamp not work for this?

Oh, there may be lots of reasons. The first one which comes to my mind is
when I archive several config files in a same directory, I rarely think
about adding '-a' to cp to preserve the dates. And when you're experimenting
with a kernel and you're at the 20th at the end of the day, the date in the
config file is often more reliable than yourself to keep track of what you
have tried.

Thanks,
Willy

PS: do you think this could be done easily to 2.4 too ?

