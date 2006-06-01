Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWFAPYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWFAPYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWFAPYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:24:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:54993 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030196AbWFAPX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:23:59 -0400
Date: Thu, 1 Jun 2006 17:23:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Martin J. Bligh" <mbligh@google.com>
cc: Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <447EFE86.7020501@google.com>
Message-ID: <Pine.LNX.4.64.0606011659030.32445@scrub.home>
References: <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org>
 <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org>
 <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org>
 <20060531221242.GA5269@elte.hu> <447E16E6.7020804@google.com>
 <20060531223243.GC5269@elte.hu> <447E1A7B.2000200@google.com>
 <20060531225013.GA7125@elte.hu> <Pine.LNX.4.64.0606011222230.17704@scrub.home>
 <447EFE86.7020501@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Jun 2006, Martin J. Bligh wrote:

> That doesn't seem to cover what we talked about clearly at all ?
> I suppose the _ALL stuff is meant to cover stuff with overhead,
> but frankly, what Ingo did seemed much clearer to me.

It just didn't make much sense, a config option only to configure the 
default value of unseen values?
If we have too many debug options, I don't mind to hide them behind an 
advanced config option, but their default values should not differ between 
their visible and hidden state, so that the user sees the real values when 
he enables the advanced option.
A config option which only configures the default values is much less 
useful, in an already configured kernel it's completely useless to an user 
who only wants to enable some runtime checks and unless he reads the help 
text _carefully_, he might even think that he just enabled some runtime 
checks. AFAIC such stuff is NACKed.

bye, Roman
