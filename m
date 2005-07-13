Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVGMTgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVGMTgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVGMTdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:33:50 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:1878 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262566AbVGMTcG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:32:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QaQ6AULAQOS2mKKRjYMp/xMWpLqlSYEpFs6XqVjRQ14fVCft/4HFMUigO4gv2xyW0jNGvOlwhoRB1Rv2r6tGHUdc0NMWjq9+9LLTmJv7iovXalO8Uc4kTeRgEmaaIPVk34LGWfqw8vZQeQEshNzHONZPeWWWn5lupGHY1i73gLk=
Message-ID: <d120d50005071312322b5d4bff@mail.gmail.com>
Date: Wed, 13 Jul 2005 14:32:02 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org,
       akpm@osdl.org, cw@f00f.org, christoph@lameter.com
In-Reply-To: <1121282025.4435.70.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <200507122239.03559.kernel@kolivas.org>
	 <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com>
	 <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com>
	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	 <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/13/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Wed, 2005-07-13 at 12:10 -0700, Linus Torvalds wrote:
> > So we should aim for a HZ value that makes it easy to convert to and from
> > the standard user-space interface formats. 100Hz, 250Hz and 1000Hz are all
> > good values for that reason. 864 is not.
> 
> How about 500?  This might be good enough to solve the MIDI problem.
>

I would expect number of laptop users significatly outnumber ones
driving MIDI so as a default entry 250 makes more sense IMHO.
 
-- 
Dmitry
