Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUBKSKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266000AbUBKSIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:08:43 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:47597 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S265946AbUBKSF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:05:56 -0500
Date: Wed, 11 Feb 2004 10:05:53 -0800
From: Larry McVoy <lm@bitmover.com>
To: Mihai RUSU <dizzy@roedu.net>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs for bkbits.net?
Message-ID: <20040211180553.GA28490@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Mihai RUSU <dizzy@roedu.net>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <200402111523.i1BFNnOq020225@work.bitmover.com> <Pine.LNX.4.58L0.0402111849240.22898@ahriman.bucharest.roedu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L0.0402111849240.22898@ahriman.bucharest.roedu.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 06:53:48PM +0200, Mihai RUSU wrote:
> As you said because its mostly read() that shouldnt matter. Dont forget 
> noatime mount option :).

Yeah, that goes for everyone else too.  BK looks at a lot of files, you
can get quite a boost by turning off atime.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
