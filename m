Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbTELMbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 08:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTELMbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 08:31:11 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:9998 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262097AbTELMbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 08:31:10 -0400
Date: Mon, 12 May 2003 13:43:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ioctl32: kill code duplication (sparc64 tester wanted)
Message-ID: <20030512134353.A28931@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030512114055.GA3539@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030512114055.GA3539@atrey.karlin.mff.cuni.cz>; from pavel@ucw.cz on Mon, May 12, 2003 at 01:40:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 01:40:55PM +0200, Pavel Machek wrote:
> Hi!
> 
> Attached patch shares ioctl32 handles between x86-64 and sparc64 (and
> it should be possible/easy to share with other archs, too).
> 
> I'd like sparc64 person to test/comment on it...

I don't have a sparc64, but there's certainly no <asm/mtrr.h> for that arch..

Also #including c files is ugly as hell.  What's the #ifdef INCLUDES
supposed to help?

