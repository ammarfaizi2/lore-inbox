Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbTLKLnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 06:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbTLKLng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 06:43:36 -0500
Received: from holomorphy.com ([199.26.172.102]:16869 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264893AbTLKLnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 06:43:35 -0500
Date: Thu, 11 Dec 2003 03:40:18 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rhino <rhino9@terra.com.br>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
Message-ID: <20031211114018.GB8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rhino <rhino9@terra.com.br>, Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Nakajima,  Jun" <jun.nakajima@intel.com>,
	Mark Wong <markw@osdl.org>
References: <3FD3FD52.7020001@cyberone.com.au> <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au> <20031211060120.4769a0e8.rhino9@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211060120.4769a0e8.rhino9@terra.com.br>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003 18:24:20 +1100 Nick Piggin wrote:
>> The "average" plot for w26 I think is a little misleading because
>> it got an unlucky result on the second last point making it look
>> like its has a downward curve. It is usually more linear with a
>> sharp downward spike at 150 rooms like the "maximum" plot.
>> Don't ask me why it runs out of steam at 150 rooms. hackbench does
>> something similar. I think it might be due to some resource running
>> short, or a scalability problem somewhere else.

On Thu, Dec 11, 2003 at 06:01:20AM -0400, Rhino wrote:
> i didn't had the time to apply the patches (w26 and C1 from ingo ) 
> on a vanilla t11, but i merged them with the wli-2,btw this one has
> really put my box on steroids ;) .
> none of them finished a hackbench 320 run, the OOM killed all of my
> agetty's logging me out. the box is a 1way p4(HT) 1gb of ram 
> and no swap heh.

It might help to check how many processes and/or threads are involved.
I've got process scalability stuff in there (I'm not sure how to read
your comments though they seem encouraging).


-- wli
