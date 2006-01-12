Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbWALNJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWALNJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 08:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWALNJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 08:09:04 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:23942 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030378AbWALNJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 08:09:03 -0500
Date: Thu, 12 Jan 2006 14:05:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
cc: john stultz <johnstul@us.ibm.com>, George Anzinger <george@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/10] NTP: add time_adjust to tick_nsec
In-Reply-To: <43C61FCA.12735.FA541A8@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.61.0601121402090.11765@scrub.home>
References: <Pine.LNX.4.61.0512220024290.30918@scrub.home>
 <43C61FCA.12735.FA541A8@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 Jan 2006, Ulrich Windl wrote:

(BTW please don't edit the Cc: header.)

> And who said that adjtime() isn't used by ntpd? "disable kernel" does exacltly 
> that I think.
> 
> As always I may be wrong...

I think you misunderstood the comment, I really meant adjtime(2) not 
adjtimex(2), I maybe should have mentioned that this about 
ADJ_OFFSET_SINGLESHOT.

bye, Roman
