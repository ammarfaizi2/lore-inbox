Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUCRJml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUCRJmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:42:40 -0500
Received: from main.gmane.org ([80.91.224.249]:34192 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262468AbUCRJmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:42:39 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: add lowpower_idle sysctl
Date: Thu, 18 Mar 2004 09:42:32 +0000 (UTC)
Message-ID: <slrnc5iro8.s2s.psavo@varg.dyndns.org>
References: <200403180031.i2I0VQF02038@unix-os.sc.intel.com> <20040317170436.430acfbe.akpm@osdl.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:
> "Kenneth Chen" <kenneth.w.chen@intel.com> wrote:
>>
>> On ia64, we need runtime control to manage CPU power state in the idle
>> loop. 
>
> Can you expand on this?  Does this mean that the admin can select different
> idle-loop algorithms?  If so, what alternative algorithms exist?

At least on 760MPX chipset, when Athlon is pushed into powersaving mode
(disconnected from PCI bus) great deal of graphical distortions are
introduced into bttv -based card's picture.
I've dealt with this by rmmod:ing amd76x_pm -module (this action disables
powersaving mode), but some sane API for disabling these disturbancies
would be much better.


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

