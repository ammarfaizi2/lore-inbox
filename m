Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbVILTUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVILTUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVILTUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:20:47 -0400
Received: from mail-gw2.turkuamk.fi ([195.148.208.126]:29911 "EHLO
	mail-gw2.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1750919AbVILTUr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:20:47 -0400
Message-ID: <4325D55E.1000707@kolumbus.fi>
Date: Mon, 12 Sep 2005 22:22:06 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 1/2] i386: consolidate discontig functions into	normal
 ones
References: <20050912175319.7C51CF96@kernel.beaverton.ibm.com>	 <4325D150.6040505@kolumbus.fi> <1126552121.5892.28.camel@localhost>
In-Reply-To: <1126552121.5892.28.camel@localhost>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.13a
  |April 8, 2004) at 12.09.2005 22:20:38,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP1|June
 19, 2005) at 12.09.2005 22:21:10,
	Serialize complete at 12.09.2005 22:21:10
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>On Mon, 2005-09-12 at 22:04 +0300, Mika Penttilä wrote:
>  
>
>>I think you allocate remap pages for nothing in the flatmem case for 
>>node0...those aren't used for the mem map in !NUMA.
>>    
>>
>
>I believe that is fixed up in the second patch.  It should compile a
>do{}while(0) version instead of doing a real call.  
>
>-- Dave
>
>
>  
>
Oh, yes, indeend it is.
Thanks,
Mika


