Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317809AbSFSICe>; Wed, 19 Jun 2002 04:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317810AbSFSICd>; Wed, 19 Jun 2002 04:02:33 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:39826 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317809AbSFSICc>;
	Wed, 19 Jun 2002 04:02:32 -0400
Date: Wed, 19 Jun 2002 10:02:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] tsc-disable_A6
Message-ID: <20020619100226.A19442@ucw.cz>
References: <1024448124.3030.139.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1024448124.3030.139.camel@cog>; from johnstul@us.ibm.com on Tue, Jun 18, 2002 at 05:55:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 05:55:19PM -0700, john stultz wrote:

> 	Here is the next revision of my tsc-disable patch. Thanks to everyone
> for providing feedback. I will re-submit this for the 2.4.20pre series,
> but wanted to get this out for additional comments as well as warn folks
> who might be trying this or my previous patch. This version reverts to
> the earlier implementation, which only changes config.in. I feel that
> defining CONFIG_X86_HAS_TSC gives one the ability to discern between
> just having a TSC and having a usable TSC, and all the current code that
> uses CONFIG_X86_TSC assumes that it is usable. This way seems cleaner
> and has all the benefits of the last method. Additionally I added the
> previously forgotten Configure.help documentation, for which I should no
> doubt receive a ruler across the knuckles.
> 

This patch looks OK.

-- 
Vojtech Pavlik
SuSE Labs
