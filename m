Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265446AbTIFATZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 20:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbTIFATZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 20:19:25 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:38150 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S265446AbTIFATX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 20:19:23 -0400
Date: Fri, 5 Sep 2003 17:19:19 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] extents support for EXT3
Message-ID: <20030906001919.GE3469@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <m33cfm19ar.fsf@bzzz.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33cfm19ar.fsf@bzzz.home.net>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Unauthorised duplication and storage of this email is a violation of international copyright law and is subject to prosecution.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 12:22:04PM +0400, Alex Tomas wrote:
> 
> this is 2nd version of the patch. changes:
>   - error handling seems completed
>   - lots of cleanups and comments
>   - few minor bug fixed
> 
> this version of the patch tries to solve couple
> of corner cases:
>   - very long truncate
>   - rewrite 
> 
> it survived dbench, bonnie++ and fsx tests.

Seems to me that moving to extents offers the perfect
opportunity to eliminate the 1 block limit of extended
attributes.  I don't see any sign of that in this patch but
i might have missed it.
