Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTHFOkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTHFOko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:40:44 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:13699 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263894AbTHFOkk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:40:40 -0400
Date: Wed, 6 Aug 2003 15:40:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Polling large file descriptor sets
Message-ID: <20030806144039.GA13363@mail.jlokier.co.uk>
References: <87y8ybw52d.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y8ybw52d.fsf@deneb.enyo.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer wrote:
> It seems that /dev/epoll support will be included in 2.6.  Is this the
> official way to solve the problem, or is there another, preferred
> interface I have missed?  Is the current /dev/epoll edge-triggered or
> level-triggered?

/dev/epoll is not included, but a similar interface using system
calls, also called epoll, is provided.  The new interface does both
edge-triggering and level-triggering, as requested.

-- Jamie
