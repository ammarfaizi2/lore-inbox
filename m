Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269987AbTHOQZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269512AbTHOQNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:13:14 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269514AbTHOQJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:37 -0400
Date: Fri, 15 Aug 2003 10:03:24 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Val Henson <val@nmt.edu>, David Wagner <daw@mozart.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815150324.GX325@waste.org>
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030815001713.GD5333@speare5-1-14> <20030815093003.A2784@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815093003.A2784@pclin040.win.tue.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 09:30:03AM +0200, Andries Brouwer wrote:
> On Thu, Aug 14, 2003 at 06:17:13PM -0600, Val Henson wrote:
> 
> > See Matt Mackall's earlier post on correlation, excerpted at the end
> > of this message.  Basically, with two strings x and y, the entropy of
> > x alone or y alone is always greater than or equal to the entropy of x
> > xored with y.
> > 
> > entropy(x) >= entropy(x xor y)
> > entropy(y) >= entropy(x xor y)
> 
> Is this trolling? Are you serious?
> Try to put z = x xor y and apply your insight to the strings x and z.

Val left out the assumption that x and y are already perfectly
distributed, in and of themselves.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
