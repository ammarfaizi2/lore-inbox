Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264819AbSJOU60>; Tue, 15 Oct 2002 16:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264821AbSJOU5F>; Tue, 15 Oct 2002 16:57:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:30158 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264819AbSJOU4u>;
	Tue, 15 Oct 2002 16:56:50 -0400
Subject: Re: [Lse-tech] Re: context switches increased in 2.5.40 kernel
To: Andrew Morton <akpm@digeo.com>
Cc: "Bill Hartner" <bhartner@us.ibm.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net, mkanand@linux.ibm.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF7BF6FED6.70527037-ON87256C53.007355BF@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Tue, 15 Oct 2002 16:02:23 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/15/2002 03:02:19 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>"David S. Miller" wrote:
>>
>>    From: Mala Anand <mkanand@us.ibm.com>
>>    Date: Tue, 15 Oct 2002 14:44:35 -0500
>>
>>    Does this have anything to do with tcp_wakeup patch?
>>
>> Please do not mention patches by name, this tells
>> me nothing.  What "tcp_wakeup patch" are you talking
>> about?

>That would be the patch which uses prepare_to_wait/finish_wait
>in networking.  It sped up specweb by 2%, btw.

>But that is not present in 2.5.40, and has not been in -mm
>since 2.5.40-mm1.  I assume it wasn't present in Mala's testing.

Yes you are correct. I am not using tcp_wakeup patch. I saw the
apis in the changelog and assumed incorrectly.



Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




