Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265242AbUBAJqT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 04:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUBAJqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 04:46:19 -0500
Received: from 62-43-4-76.user.ono.com ([62.43.4.76]:40913 "EHLO
	mortadelo.pirispons.net") by vger.kernel.org with ESMTP
	id S265242AbUBAJqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 04:46:17 -0500
Date: Sun, 1 Feb 2004 10:46:16 +0100
From: Kiko Piris <kernel@pirispons.net>
To: Jim McCloskey <mcclosk@ucsc.edu>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: net-pf-10, 2.6.1
Message-ID: <20040201094616.GA28327@pirispons.net>
Mail-Followup-To: Jim McCloskey <mcclosk@ucsc.edu>,
	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
References: <E1AnDuR-0000Jj-00@toraigh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AnDuR-0000Jj-00@toraigh>
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2004 at 01:28, Jim McCloskey wrote:

> I've tried the variations I can think of---putting the line:
> 
>    install net-pf-10 /bin/true
> 
> in /lib/modules/modprobe.conf via update-modules, or directly by hand-editing.
> Then depmod; then reboot. Also:
> 
>    install net-pf-10-* /bin/true
>    install net-pf-* /bin/true

AFAIK, this was fixed in 3.0-pre6 version of module-init-tools:

http://marc.theaimsgroup.com/?l=linux-kernel&m=107449592106965&w=2

Why don't you just upgrade it and forget those ugly workarounds?

I don't know which distro you are running, 3.0-pre9-1 got into debian
sid today or yesterday.

Cheers

-- 
Kiko
