Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVCXRAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVCXRAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 12:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbVCXRAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 12:00:16 -0500
Received: from mx1.suse.de ([195.135.220.2]:62104 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262871AbVCXQ6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 11:58:35 -0500
Message-ID: <4242CE43.1020806@suse.de>
Date: Thu, 24 Mar 2005 15:27:15 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
References: <20050323184919.GA23486@hexapodia.org>
In-Reply-To: <20050323184919.GA23486@hexapodia.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:

> Dmesg is attached; hardware is a Vaio r505te.
> 
> Unfortunately, the deadlock (?) is nondeterministic; it *sometimes*
> suspends successfully, maybe one time out of 10.  And thinking back, I
> *sometimes* saw failures to suspend with 2.6.11-rc3, maybe one failure
> out of 20 suspends.

Does it hang hard or is sysrq still working?
If sysrq is still working, please try with "i8042.noaux" (this will kill
your touchpad, which is what i intend :-)

Best regards,

    Stefan



