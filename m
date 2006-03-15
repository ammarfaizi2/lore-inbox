Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWCOOVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWCOOVx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 09:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbWCOOVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 09:21:53 -0500
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:8089 "EHLO
	pne-smtpout3-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751878AbWCOOVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 09:21:53 -0500
Date: Wed, 15 Mar 2006 16:21:48 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Cc: Jiri Tyr <jiri.tyr@cern.ch>, video4linux-list@redhat.com
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
Message-ID: <20060315142148.GD20607@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org, Jiri Tyr <jiri.tyr@cern.ch>,
	video4linux-list@redhat.com
References: <440C5672.7000009@cern.ch> <200603061656.18846.duncan.sands@math.u-psud.fr> <440D7384.5030307@cern.ch> <200603071332.19614.baldrick@free.fr> <4417D4ED.6010808@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4417D4ED.6010808@cern.ch>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 09:48:45AM +0100, Jiri Tyr wrote:
> Hi,
> 
> I think, it's problem in XAWTV, because I've got the same error if I
> had only one TV tuner in my PC. I've solved the problem that I reduced
> number of items in channel list. If I have in the list only 10
> channels, then any of the four XAWTV didn't crashed. It's very
> strange. It looks like the pop-up menu with the channel list write to
> the memory of the graphics card somewhere out of the memory. What do
> you think about it?

I didn't change xawtv configs, and
1) with the patch system did not crash
2) without the patch system crashed

draw your own conclusions.

and
3) if xawtv is able to crash kernel, kernel needs fixing.

-- 
