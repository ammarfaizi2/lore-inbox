Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVDHSUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVDHSUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVDHSUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:20:20 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:39097 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262919AbVDHSRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:17:43 -0400
Date: Fri, 8 Apr 2005 20:17:41 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] restrict inter_module_* to its last users
Message-ID: <20050408181741.GA12170@wohnheim.fh-wedel.de>
References: <20050408170805.GE2292@wohnheim.fh-wedel.de> <20050408104826.3ca70fb4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050408104826.3ca70fb4.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 April 2005 10:48:26 -0700, Andrew Morton wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> >
> > Next step for inter_module removal.  This patch makes the code
> >  conditional on its last users and shrinks the kernel binary for the
> >  huge majority of people.
> 
> If we do this, nobody will get around to fixing up the remaining users.

I would do that personally if someone explained inter_module_* to me.
Right now, I have absolutely no clue what the perceived problem was
and how inter_module_* supposedly solved that problem.

Jörn

-- 
The strong give up and move away, while the weak give up and stay.
-- unknown
