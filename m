Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbUKXU6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbUKXU6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbUKXU6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:58:54 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:38016 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262681AbUKXU6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:58:52 -0500
Subject: Re: Suspend 2 merge: 14/51: Disable page alloc failure message
	when suspending
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041124141521.GA13915@infradead.org>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101294838.5805.245.camel@desktop.cunninghams>
	 <20041124141521.GA13915@infradead.org>
Content-Type: text/plain
Message-Id: <1101329172.3895.0.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 07:46:21 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 01:15, Christoph Hellwig wrote:
> On Wed, Nov 24, 2004 at 11:57:55PM +1100, Nigel Cunningham wrote:
> > While eating memory, we will potentially trigger this a lot. We
> > therefore disable the message when suspending.
> 
> So call the allocator with __GFP_NOWARN

Everywhere?

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

