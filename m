Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbTGCQN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265013AbTGCQLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:11:19 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:8720 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264976AbTGCQJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:09:34 -0400
Date: Thu, 3 Jul 2003 17:23:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-ID: <20030703172358.B10499@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, akpm@digeo.com,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <UTC200307022100.h62L06a22118.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200307022100.h62L06a22118.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Wed, Jul 02, 2003 at 11:00:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 11:00:06PM +0200, Andries.Brouwer@cwi.nl wrote:
> No, the point of such a series is that each patch does something
> clearly defined, is an improvement even when the author dies the
> next day so that all further work is lost.

*nod*

> You should never accept a patch that makes things worse and is only
> justified by a future one.

well, I almost agree.  If the other patch is posted at the same time
or the regression is for less important code (say a legacy driver)
this can be ok.

>     So for everyone except the guy who's writing the code it is best to have
>     all the work in place and reviewable at the same time.
> 
> No. Some changes are too large for that.

right, there's changes that are too large.  But it really helps a lot
to send a series of patches to give a broader view.

