Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVCNEJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVCNEJz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 23:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVCNEJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 23:09:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:34177 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261948AbVCNEIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 23:08:21 -0500
Date: Sun, 13 Mar 2005 20:07:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg Stark <gsstark@mit.edu>
Cc: s0348365@sms.ed.ac.uk, gsstark@mit.edu, linux-kernel@vger.kernel.org,
       pmcfarland@downeast.net
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
Message-Id: <20050313200753.20411bdb.akpm@osdl.org>
In-Reply-To: <87sm2y7uon.fsf@stark.xeocode.com>
References: <87u0ng90mo.fsf@stark.xeocode.com>
	<200503130152.52342.pmcfarland@downeast.net>
	<874qff89ob.fsf@stark.xeocode.com>
	<200503140103.55354.s0348365@sms.ed.ac.uk>
	<87sm2y7uon.fsf@stark.xeocode.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark <gsstark@mit.edu> wrote:
>
> In any case "X code is broken" "why not use Y code instead" isn't really
>  productive. It's a good thing I was using the OSS drivers; if everyone used
>  the alsa drivers and nobody was testing the OSS drivers nobody would know they
>  were broken.

I would agree with that.  If it's in the tree and the config system offers
it, it should work.  And if it _used_ to work, and no longer does so then
double bad.

Are you able to narrow it down to something more fine grained than "between
2.6.6 and 2.6.9-rc1"?


