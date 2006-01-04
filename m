Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWADTUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWADTUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWADTUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:20:07 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:46857 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751268AbWADTUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:20:06 -0500
Date: Wed, 4 Jan 2006 20:19:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Robin Holt <holt@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/26] kbuild: Fix genksyms handling of DEFINE_PER_CPU(struct foo_s *, bar);
Message-ID: <20060104191950.GA9321@mars.ravnborg.org>
References: <20060103132035.GA17485@mars.ravnborg.org> <11362947262643@foobar.com> <20060104190130.GA20175@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104190130.GA20175@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 01:01:30PM -0600, Robin Holt wrote:
> Sam,
> 
> I just finally got caught up from vacation and noticed that you do
> not have a patch which rebuilds keywords.c_shipped, lex.c_shipped,
> parse.c_shipped, parse.h_shipped.  Did I miss a patch in this set?

Hi Robin.

I combined them all in one patch wich caused lkml filter to eat it.
The patch now includes documentation on version of tools used.

You can see the patch here:
http://www.kernel.org/git/?p=linux/kernel/git/sam/kbuild.git;a=commit;h=c40f56409d01f6f1ea80ed4c229096749c2335df

Since is is all auto-generated code I see no gain in splitting up the
code so it can be published on lkml.

	Sam
