Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWAYJUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWAYJUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWAYJUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:20:37 -0500
Received: from mail.suse.de ([195.135.220.2]:56806 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751068AbWAYJUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:20:36 -0500
Message-ID: <43D742E2.1070701@suse.de>
Date: Wed, 25 Jan 2006 10:20:34 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Ben Collins <bcollins@ubuntu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP alternatives
References: <43D648CC.4090101@suse.de> <1138119764.4207.7.camel@grayson>
In-Reply-To: <1138119764.4207.7.camel@grayson>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> FYI, I have this being used in Ubuntu's kernel right now. It's pretty
> stable. I have it implemented for x86_64 aswell. I can send you that
> patch when I get a chance to pull it from the repo cleanly. I did enable
> a kconfig option and command line option so it can be enabled/disabled
> by default and also at boot.

The x86_64 bits would be very nice.  Linus' didn't like the idea to make
that a config option, commented "either it works or it doesn't", so I
left it out.  The code is small anyway, and the data tables can be
freed, so making it an option doesn't make much sense.  IMHO there are
way to many config options anyway ...

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
