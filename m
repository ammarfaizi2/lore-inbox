Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbUKXOJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbUKXOJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUKXOGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:06:54 -0500
Received: from zeus.kernel.org ([204.152.189.113]:35277 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262719AbUKXNkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:40:18 -0500
Date: Wed, 24 Nov 2004 13:28:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge
Message-ID: <20041124132839.GA13145@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 11:56:35PM +1100, Nigel Cunningham wrote:
> Hi everyone.
> 
> I know that I still have work to do on suspend2, but thought it was high
> time I got around to properly submitting the code for review, so here
> goes.
> 
> I have it split up into 51 patches, of which most are less than 20k,
> although there are three 50k patches. Changes to the rest of the kernel
> tree come first, then the core. The full tree can be found at

Your way of merging looks rather wrong.  Please submit changes against the
current swsusp code that introduce one feature after another to bring it
at the level you want.  You'll surely have to rewrok it a lot until all
reviewers are happy.

And most importantly for each patch explain exactly what feature it
implements and why, etc..  "swsusp2" tells exactly nothing about the
changed you do.

