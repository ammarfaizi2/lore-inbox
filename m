Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbUKXOVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbUKXOVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbUKXOUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:20:33 -0500
Received: from [213.146.154.40] ([213.146.154.40]:40670 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262658AbUKXOPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:15:22 -0500
Date: Wed, 24 Nov 2004 14:15:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 14/51: Disable page alloc failure message when suspending
Message-ID: <20041124141521.GA13915@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101294838.5805.245.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101294838.5805.245.camel@desktop.cunninghams>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 11:57:55PM +1100, Nigel Cunningham wrote:
> While eating memory, we will potentially trigger this a lot. We
> therefore disable the message when suspending.

So call the allocator with __GFP_NOWARN
