Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTF0LMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 07:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbTF0LMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 07:12:25 -0400
Received: from [213.171.53.133] ([213.171.53.133]:42764 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id S264178AbTF0LMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 07:12:24 -0400
Date: Fri, 27 Jun 2003 14:28:29 +0400
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, akpm@digeo.com
Subject: Re: [BIO] request->flags ambiguity
Message-Id: <20030627142829.5aea7015.deepfire@ibe.miee.ru>
In-Reply-To: <20030627104822.GE821@suse.de>
References: <20030627134756.4118617e.deepfire@ibe.miee.ru>
	<20030627104822.GE821@suse.de>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jun 2003 12:48:22 +0200
Jens Axboe <axboe@suse.de> wrote:
-- snip --
> > 	Is it ok to have a possibility of a request with conflicting
> > 	meanings attached to it?  For example REQ_CMD | REQ_PM_SHUTDOWN
> > 	| REQ_SPECIAL.
> 
> No of course not.
-- snip --
> > 	Shouldn`t it make more sense to separate request-type-indicator
> > 	flags into a separate unambiguous type field, which would take
> > 	one of the following values: - read/write request - sense query
> > 	- power control - special request
> > 
> > 	And not a currently possible combination of all of them, which
> > 	seem to be the current situation.
> 
> There has been talk of that before, search the archives.

	Umm, i`ve tried and failed, couldn`t you share some vague pointers about the topic
 or something?

	I`m sorry, but my curiosity prevailed over hesitation to bother you :-)
> 
> -- 
> Jens Axboe
> 
> 
--
regards, Samium Gromoff


-- 
