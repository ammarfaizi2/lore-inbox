Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752357AbWCPKzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbWCPKzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbWCPKzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:55:18 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:9138 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1752356AbWCPKzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:55:16 -0500
Date: Thu, 16 Mar 2006 11:55:15 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: does swsusp suck after resume for you?
Message-ID: <20060316105515.GA29960@rhlx01.fht-esslingen.de>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060315103711.GA31317@suse.de> <20060315175948.GB2423@ucw.cz> <200603162133.26771.kernel@kolivas.org> <20060316104630.GA9399@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316104630.GA9399@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 16, 2006 at 11:46:30AM +0100, Pavel Machek wrote:
> Looks okay, but... what happens if I set /proc/sys/vm/swap_prefetch to
> "2"? Do nothing but do it agresively?
> 
> Maybe having 0 = off, 1 = normal, 2 = aggressive would be less error
> prone for the users.

Hmm, that way you'd prevent further extension of the bitmask (in a
bitmask-only-tunable manner, that is).
BTW: do we want (to avoid) more tunables or more bitmask tunables with
thus more options? Good general question, methinks...
And I don't think that having value 2 set exclusively would hurt.

Andreas
