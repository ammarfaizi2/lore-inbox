Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVIIDs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVIIDs6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 23:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbVIIDs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 23:48:58 -0400
Received: from mx1.suse.de ([195.135.220.2]:9695 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965019AbVIIDs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 23:48:57 -0400
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] abstraction of i386 machine check handlers
References: <432075E502000078000244AE@emea1-mh.id2.novell.com>
From: Andi Kleen <ak@suse.de>
Date: 09 Sep 2005 05:48:56 +0200
In-Reply-To: <432075E502000078000244AE@emea1-mh.id2.novell.com>
Message-ID: <p73y8663npz.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> writes:

> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> This adjusts the i386 machine check infrastructure so that replacing
> the
> underlying exception handling code can be done by adjusting just a
> single
> definition rather than many different files.

Quite ugly.

How about just adding die notifiers there instead and then hooking
them? 

-Andi
