Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318536AbSHUSFx>; Wed, 21 Aug 2002 14:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318542AbSHUSFx>; Wed, 21 Aug 2002 14:05:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:41682 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318536AbSHUSFx>; Wed, 21 Aug 2002 14:05:53 -0400
Subject: Re: (RFC): SKB Initialization
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, Bill Hartner <bhartner@us.ibm.com>,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF874EB8CD.B30B589E-ON87256C1C.00634F29@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Wed, 21 Aug 2002 13:07:09 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/21/2002 12:07:09 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Wed, Aug 21, 2002 at 11:59:44AM -0500, Mala Anand wrote:
>> The patch reduces the numer of cylces by 25%

>The data you are reporting is flawed: where are the average cycle
>times spent in __kfree_skb with the patch?

I measured the cycles for only the initialization code in alloc_skb
and __kfree_skb. Since the init code is removed from __kfree_skb,
no cycles are spent there.



Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.comdeveloperworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




