Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVERAUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVERAUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVERAUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 20:20:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:56539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262002AbVERAU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 20:20:26 -0400
Date: Tue, 17 May 2005 17:20:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Optimize sys_times for a single thread process
Message-Id: <20050517172059.615d144f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505171708250.18365@graphe.net>
References: <Pine.LNX.4.62.0505171536080.15653@graphe.net>
	<20050517161000.5e0fb0a9.akpm@osdl.org>
	<Pine.LNX.4.62.0505171708250.18365@graphe.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
> > It all looks a bit fast-and-loose.  If there are significant performance
> > benefits and these issues are loudly commented (they aren't at present)
> > then maybe-OK, I guess.
> 
> There are significant performance benefits in particular for one standard 
> NUMA benchmark that keeps calling sys_times over and over. I believe other 
> programs may exhibit the same brain dead behavior.


hrm, OK.  Please redo the patch with nice comments which explain what's
going on and why the end result is correct and safe, thanks.

