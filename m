Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268325AbUIPP3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268325AbUIPP3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268322AbUIPP3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:29:07 -0400
Received: from sd291.sivit.org ([194.146.225.122]:21418 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268365AbUIPP2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:28:42 -0400
Date: Thu, 16 Sep 2004 17:29:19 +0200
From: Stelian Pop <stelian@popies.net>
To: Buddy Lucas <buddy.lucas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040916152919.GG3146@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Buddy Lucas <buddy.lucas@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040913135253.GA3118@crusoe.alcove-fr> <20040915153013.32e797c8.akpm@osdl.org> <20040916064320.GA9886@deep-space-9.dsnet> <20040916000438.46d91e94.akpm@osdl.org> <20040916104535.GA3146@crusoe.alcove-fr> <5d6b657504091608093b171e30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6b657504091608093b171e30@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 05:09:51PM +0200, Buddy Lucas wrote:

> > +       total = remaining = min(len, fifo->size - fifo->tail + fifo->head);
> 
> I could be mistaken (long day at the office ;-) but doesn't this fail after 
> wrapping?

No, because the type is *unsigned* int. 

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
