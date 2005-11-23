Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVKWPVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVKWPVT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVKWPVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:21:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:45793 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750998AbVKWPVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:21:18 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Jon Smirl <jonsmirl@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Early boot issues (WAS: Christmas list for the kernel)
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	<20051122204918.GA5299@kroah.com> <1132729836.26560.318.camel@gaston>
From: Andi Kleen <ak@suse.de>
Date: 23 Nov 2005 12:47:59 -0700
In-Reply-To: <1132729836.26560.318.camel@gaston>
Message-ID: <p73veyji1sg.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> I think it is be rather very unsafe to have /sbin/hotplug be called
> before the system finishes with all initcalls...

Yes it is - it unconvered some very interesting MM problems on x86-64
(now fixed, but there might be more lurking)

-Andi
