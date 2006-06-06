Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWFFKtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWFFKtc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 06:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWFFKtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 06:49:32 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:24275 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751150AbWFFKtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 06:49:32 -0400
Date: Tue, 6 Jun 2006 12:49:30 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64: 64 bit kernel 32 bit userland - some pending questions
Message-ID: <20060606104930.GN4552@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20060606093456.GL4552@cip.informatik.uni-erlangen.de> <p73lksazht5.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73lksazht5.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andi,

> The main caveat is that iptables and ipsec need 64bit executables to
> be set up. The rest should work.

I see. But that isn't a showstopper for me because I can compile
iptables myself and the machines are protected through another firewall
anyway.

> The default is 4GB, but you can get 3GB by running it under linux32
> --3gb

4 Gbyte is fine for me.

> The 64bit kernel never uses highmem.

I see, it wouldn't make any sense.

> If all fails you can get a cross compiler from crosstool.
> Then normal kernel compilation command with 

> make ... ARCH=x86_64 CROSS_COMPILE=x86_64-linux-

I see.

Thanks a lot for your feedback,
                                Thomas
