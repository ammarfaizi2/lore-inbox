Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSEXOgQ>; Fri, 24 May 2002 10:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317139AbSEXOgP>; Fri, 24 May 2002 10:36:15 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:5543 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S317136AbSEXOgO>;
	Fri, 24 May 2002 10:36:14 -0400
Date: Fri, 24 May 2002 07:35:32 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Message-ID: <1572079531.1022225730@[10.10.2.3]>
In-Reply-To: <200205241004.g4OA4Ul28364@mail.pronto.tv>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Sounds like exactly the same problem we were having. There are two
>> approaches to solving this - Andrea has a patch that tries to free them
>> under memory pressure, akpm has a patch that hacks them down as soon
>> as you've fininshed with them (posted to lse-tech mailing list). Both
>> approaches seemed to work for me, but the performance of the fixes still
>> has to be established.
> 
> Where can I find the akpm patch?

http://marc.theaimsgroup.com/?l=lse-tech&m=102083525007877&w=2

> Any plans to merge this into the main kernel, giving a choice 
> (in config or /proc) to enable this?

I don't think Andrew is ready to submit this yet ... before anything
gets merged back, it'd be very worthwhile testing the relative
performance of both solutions ... the more testers we have the
better ;-)

Thanks,

M.

