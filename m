Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbTGCQeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTGCQK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:10:58 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:6160 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264930AbTGCQGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:06:19 -0400
Date: Thu, 3 Jul 2003 17:20:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-ID: <20030703172042.A10499@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, akpm@digeo.com,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Wed, Jul 02, 2003 at 08:44:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 08:44:18PM +0200, Andries.Brouwer@cwi.nl wrote:
> > and this transfer function then immediately goes from (addr,len)
> > to (page/offset/len). That's rather silly ..
> 
> Changing that would kill all existing modules that use the loop device.

I don't think that matters.  This is 2.5 and APIs tend to change
in unstable series :)  Do you know of any users except the various
cryptoloop implementations?

