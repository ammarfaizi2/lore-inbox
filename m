Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSILTdd>; Thu, 12 Sep 2002 15:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSILTdd>; Thu, 12 Sep 2002 15:33:33 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:2806 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317091AbSILTdd>;
	Thu, 12 Sep 2002 15:33:33 -0400
Message-ID: <3D80EB90.3020304@watson.ibm.com>
Date: Thu, 12 Sep 2002 15:31:28 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Linux Aio <linux-aio@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 port of aio-20020619 for raw devices
References: <3D80DB14.2040809@watson.ibm.com> <20020912143540.J18217@redhat.com> <3D80DEF4.1080906@watson.ibm.com> <20020912145324.L18217@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

>On Thu, Sep 12, 2002 at 02:37:40PM -0400, Shailabh Nagar wrote:
>
>>So does the kvec structure go away (and some variant of dio get used) ?
>>
>
>That's orthogonal.  kvecs are really just bio_vecs for use by any code 
>that has to pass around data that is scatter-gathered.
>
>		-ben
>
I see. So generic_aio_rw would directly call some function which used 
dio's rather than map the kvec first and call a kvec_op  ?


