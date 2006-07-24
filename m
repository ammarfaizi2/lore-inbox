Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWGXUpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWGXUpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 16:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWGXUpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 16:45:18 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:13123 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751431AbWGXUpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 16:45:17 -0400
Message-ID: <44C53323.2030905@gentoo.org>
Date: Mon, 24 Jul 2006 21:52:51 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Matt LaPlante <kernel1@cyberdogtech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question about Git tree methodology.
References: <20060724163145.5819ce7d.kernel1@cyberdogtech.com>
In-Reply-To: <20060724163145.5819ce7d.kernel1@cyberdogtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt LaPlante wrote:
> Hi all, I've been playing around with setting up a personal git tree
> for kernel patches.  I've followed Jeff Garzik's guide, as well as
> some of the kernel.org docs.  I have no problem setting it up,
> however I have a question about which method to use for my tree.
> Basically I just want to use it as a method of tracking my own
> trivial patches (and perhaps give maintainers easier access to them).

Quilt is very good at doing this kind of thing.
http://savannah.nongnu.org/projects/quilt

It keeps all your patches in a "patches" subdirectory and makes going 
back and fixing previous patches very easy (git makes this quite hard). 
You can rsync your patches/ directory to any webserver, and anyone else 
can save them in a patches subdirectory and apply them in the same way 
(the equivalent of sharing your tree).

Daniel

