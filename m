Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWJEUkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWJEUkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWJEUkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:40:22 -0400
Received: from eastrmmtao04.cox.net ([68.230.240.35]:60051 "EHLO
	eastrmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932103AbWJEUkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:40:19 -0400
Subject: Re: Free memory level in 2.6.16?
From: Steve Bergman <sbergman@rueb.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <p73k63ezg3y.fsf@verdi.suse.de>
References: <1160034527.23009.7.camel@localhost>
	 <p73k63ezg3y.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 15:41:19 -0500
Message-Id: <1160080879.29452.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 22:01 +0200, Andi Kleen wrote:

> 
> You could play with /proc/sys/vm/lowmem_reserve_ratio but must
> likely some defaults need tweaking.

Hmmm, after a bit of googling and a download of 2.6.18, it seems that
documentation on lowmem_reserve_ratio is still on the todo list.

cat /proc/sys/vm/lowmem_reserve_ratio 

gives me "256 256 32" on the system in question.  Can someone give me a
quick rundown of what this means?

Thanks,
Steve Bergman

