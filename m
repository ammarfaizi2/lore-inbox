Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSHWXK1>; Fri, 23 Aug 2002 19:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSHWXK1>; Fri, 23 Aug 2002 19:10:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1997 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313628AbSHWXK1>;
	Fri, 23 Aug 2002 19:10:27 -0400
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
To: nevdull@beaverton.ibm.com
Cc: "Bill Hartner" <bhartner@us.ibm.com>, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF1EB59440.3960EB14-ON87256C1E.007B34C6@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Fri, 23 Aug 2002 18:14:26 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/23/2002 05:14:26 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rick wrote..
>Note that Mala said "I measured the cycles for only the
>initialization code in alloc_skb and __kfree_skb" which could mean that
>even other parts of alloc_skb() or __kfree_skb() may have gotten worse
>and you would not have known.
 Please look at my reply to Ben LeHaise which has the cycles for
 alloc_skb() and __kfree_skb(). You don't have to guess that.

> Later she admits, "As the scope of the
>code measured widens the percentage improvement comes down" and finally
>observes "We measured it in a web serving workload and found that we
>get 0.7% improvement"  which is practically in the noise.
That was initial results which had more than the posted patch. We are
still working on getting numbers.

>Dave's
>observation was that it was slightly worse (0.35%).
Are you basing this 0.35% degradation on your profile. According to
Dave's SPECweb99 results there is a 2.97% improvement in simultaneous
connections with my patch. Is that right Dave?




Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088






