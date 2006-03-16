Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWCPNVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWCPNVR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 08:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWCPNVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 08:21:17 -0500
Received: from styx.suse.cz ([82.119.242.94]:46791 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750867AbWCPNVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 08:21:16 -0500
Date: Thu, 16 Mar 2006 14:21:14 +0100
From: Jiri Benc <jbenc@suse.cz>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Bernd Petrovitsch <bernd@firmix.at>, rusty@rustcorp.com.au,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modpost: fix buffer overflow
Message-ID: <20060316142114.74367113@griffin.suse.cz>
In-Reply-To: <20060315225159.GA11095@mars.ravnborg.org>
References: <20060315154436.4286d2ab@griffin.suse.cz>
	<1142434648.17627.5.camel@tara.firmix.at>
	<20060315160858.311e5c0e@griffin.suse.cz>
	<20060315225159.GA11095@mars.ravnborg.org>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2006 23:51:59 +0100, Sam Ravnborg wrote:
> Can I ask you to make a new patch where you change buf_printf() to use
> buf_write. And then change buf_write to allocate in chunks also.
> This would be cleanest solution.

This probably will be the cleanest solution, but I doubt it would be
acceptable for 2.6.16. And I think the fix should go into 2.6.16.

Thanks,

-- 
Jiri Benc
SUSE Labs
