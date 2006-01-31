Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWAaMfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWAaMfo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 07:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWAaMfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 07:35:44 -0500
Received: from ns.suse.de ([195.135.220.2]:17536 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750790AbWAaMfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 07:35:43 -0500
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pass proper trap numbers to die chain handlers
References: <43DDF02E.76F0.0078.0@novell.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
In-Reply-To: <43DDF02E.76F0.0078.0@novell.com.suse.lists.linux.kernel>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Date: 31 Jan 2006 13:35:39 +0100
Message-ID: <p73acdcmv6s.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> writes:

> From: Jan Beulich <jbeulich@novell.com>
> 
> Pass the trap number causing the call to notify_die() to the die
> notification handler chain in a number of instances. Also, honor the
> return value from the handler chain invocation in die() as, through a

Looks good to me. Feel free to add a Acked-by: ak@suse.de.

-Andi
