Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbTFQWIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbTFQWIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:08:13 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:44726 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264949AbTFQWIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:08:10 -0400
Date: Wed, 18 Jun 2003 00:21:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: davidm@hpl.hp.com
Cc: Riley Williams <Riley@Williams.Name>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Message-ID: <20030618002146.A20956@ucw.cz>
References: <16110.4883.885590.597687@napali.hpl.hp.com> <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name> <16111.37901.389610.100530@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16111.37901.389610.100530@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Tue, Jun 17, 2003 at 03:19:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 03:19:57PM -0700, David Mosberger wrote:

> >>>>> On Tue, 17 Jun 2003 23:11:46 +0100, "Riley Williams" <Riley@Williams.Name> said:
> 
>   Riley> [CLOCK_TICK_RATE] needs to be declared there. The only
>   Riley> question is regarding the value it is defined to, and it
>   Riley> would have to be somebody with better knowledge of the ia64
>   Riley> than me who decides that. All I can do is to post a
>   Riley> reasonable default until such decision is made.
> 
> The ia64 platform architecture does not provide for such a timer and
> hence there is no reasonable value that the macro could be set to.

It seems to be used for making beeps, even on that architecture.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
