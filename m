Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbUKRGHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUKRGHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbUKRGHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:07:55 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:20710 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262608AbUKRGHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:07:50 -0500
Date: Thu, 18 Nov 2004 16:05:01 +1100
From: Nathan Scott <nathans@sgi.com>
To: Brad Fitzpatrick <brad@danga.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Lisa Phillips <lisa@danga.com>, Mark Smith <marksmith@danga.com>,
       linux-xfs@oss.sgi.com
Subject: Re: 2.6.9: unkillable processes during heavy IO
Message-ID: <20041118050501.GD9834@frodo>
References: <Pine.LNX.4.58.0411141403040.22805@danga.com> <Pine.LNX.4.58.0411160549070.7904@danga.com> <20041116200156.2b2526e5.akpm@osdl.org> <20041117045506.GA1802@frodo> <Pine.LNX.4.58.0411162251170.7904@danga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411162251170.7904@danga.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 11:00:41PM -0800, Brad Fitzpatrick wrote:
> > Brad, could you send me details on how you've setup mysqld
> > and how to generate a load similar to yours, so that I can
> > reproduce the hang locally?
> 
> The MySQL people made a tool to reproduce MySQL-like load for the specific
> purpose of not putting you through the database setup pain:

Ah, fantastic.

I've reproduced it now with this tool and a simplified version
of your recipe - I'll have a fix for you to try before too long.

> Well, sysbench should help you find the problem.

Yep, it sure did.

thanks!

-- 
Nathan
