Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUBKMpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 07:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbUBKMpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 07:45:07 -0500
Received: from mail.shareable.org ([81.29.64.88]:21633 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264361AbUBKMpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 07:45:04 -0500
Date: Wed, 11 Feb 2004 12:45:02 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: open-scale-2.6.2-A0
Message-ID: <20040211124502.GG15127@mail.shareable.org>
References: <20040211115828.GA13868@elte.hu> <20040211122031.GC15127@mail.shareable.org> <20040211122753.GA15129@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040211122753.GA15129@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> > Does this scalability improvement make any measured difference in any
> > conceivable application, or is it just making struct inode larger?
> 
> i've not added any new lock, i'm merely reusing the existing ->i_lock. 
> So there's no data or code bloat whatsoever.

Oh of course (duh!).

-- Jamie
