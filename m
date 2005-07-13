Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbVGMTjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVGMTjK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVGMTge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:36:34 -0400
Received: from dvhart.com ([64.146.134.43]:54198 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262443AbVGMTd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:33:59 -0400
Date: Wed, 13 Jul 2005 12:33:47 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: dtor_core@ameritech.net, Lee Revell <rlrevell@joe-job.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org,
       akpm@osdl.org, cw@f00f.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <341450000.1121283227@flay>
In-Reply-To: <d120d50005071312322b5d4bff@mail.gmail.com>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <200507122239.03559.kernel@kolivas.org> <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, July 13, 2005 14:32:02 -0500 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi,
> 
> On 7/13/05, Lee Revell <rlrevell@joe-job.com> wrote:
>> On Wed, 2005-07-13 at 12:10 -0700, Linus Torvalds wrote:
>> > So we should aim for a HZ value that makes it easy to convert to and from
>> > the standard user-space interface formats. 100Hz, 250Hz and 1000Hz are all
>> > good values for that reason. 864 is not.
>> 
>> How about 500?  This might be good enough to solve the MIDI problem.
>> 
> 
> I would expect number of laptop users significatly outnumber ones
> driving MIDI so as a default entry 250 makes more sense IMHO.

Could someone actually test it, rather than randomly guessing? ;-)

M.

