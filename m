Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbSJ2Wds>; Tue, 29 Oct 2002 17:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSJ2Wds>; Tue, 29 Oct 2002 17:33:48 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:28329 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262418AbSJ2Wdr> convert rfc822-to-8bit; Tue, 29 Oct 2002 17:33:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Date: Tue, 29 Oct 2002 23:39:55 +0100
User-Agent: KMail/1.4.1
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
References: <200210280132.33624.efocht@ess.nec.de> <200210281838.44556.efocht@ess.nec.de> <536200000.1035826605@flay>
In-Reply-To: <536200000.1035826605@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210292339.55322.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 October 2002 18:36, Martin J. Bligh wrote:
> >> Schedbench 4:
> >>                              Elapsed   TotalUser    TotalSys     AvgUser
> >>               2.5.44-mm4       32.45       49.47      129.86        0.82
> >>       2.5.44-mm4-focht-1       38.61       45.15      154.48        1.06
> >>       2.5.44-mm4-hbaum-1       37.81       46.44      151.26        0.78
> >>      2.5.44-mm4-focht-12       23.23       38.87       92.99        0.85
> >>      2.5.44-mm4-hbaum-12       22.26       34.70       89.09        0.70
> >>         2.5.44-mm4-f1-h2       21.39       35.97       85.57        0.81
> >
> > One more remarks:
> > You seem to have made the numa_test shorter. That reduces it to beeing
> > simply a check for the initial load balancing as the hackbench running in
> > the background (and aimed to disturb the initial load balancing) might
> > start too late. You will most probably not see the impact of node
> > affinity with such short running tests. But we weren't talking about node
> > affinity, yet...
>
> I didn't modify what you sent me at all ... perhaps my machine is
> just faster than yours?
>
> /me ducks & runs ;-)

Aaargh, now I understand!!! You just have wrong labels in your table,
they are permuted! More sense makes:

> >>                              AvgUser       Elapsed   TotalUser    TotalSys
> >>               2.5.44-mm4       32.45       49.47      129.86        0.82
> >>       2.5.44-mm4-focht-1       38.61       45.15      154.48        1.06
> >>       2.5.44-mm4-hbaum-1       37.81       46.44      151.26        0.78
> >>      2.5.44-mm4-focht-12       23.23       38.87       92.99        0.85
> >>      2.5.44-mm4-hbaum-12       22.26       34.70       89.09        0.70
> >>         2.5.44-mm4-f1-h2       21.39       35.97       85.57        0.81

Regards,
Erich

