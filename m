Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWGHOA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWGHOA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 10:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWGHOA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 10:00:58 -0400
Received: from mail.suse.de ([195.135.220.2]:19681 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964842AbWGHOA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 10:00:57 -0400
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Use target filename in BUG_ON and friends
References: <20060708084713.GA8020@mars.ravnborg.org>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2006 16:00:55 +0200
In-Reply-To: <20060708084713.GA8020@mars.ravnborg.org>
Message-ID: <p73sllcnqlk.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:
> 
> If gcc could be teached not to use full path for __FILE__ this would be
> an even better fix, but with current make O=.. support I have not found a
> way to do so.

I suppose you could ask the gcc people? 

> 
> Patch below only modify x86_64, but if this is accepted all arch's bug.h
> will be fixed.

Looks good to me.

-Andi
