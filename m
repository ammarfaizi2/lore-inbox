Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317546AbSGETst>; Fri, 5 Jul 2002 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317547AbSGETss>; Fri, 5 Jul 2002 15:48:48 -0400
Received: from otter.mbay.net ([206.55.237.2]:19973 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S317546AbSGETsr> convert rfc822-to-8bit;
	Fri, 5 Jul 2002 15:48:47 -0400
From: John Alvord <jalvo@mbay.net>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Pablo Fischer <exilion@yifan.net>, Mark Hahn <hahn@physics.mcmaster.ca>,
       <linux-kernel@vger.kernel.org>
Subject: Re: StackPages errors (CALLTRACE)
Date: Fri, 05 Jul 2002 12:50:57 -0700
Message-ID: <83ubiu433pkcf41ev9ihl7mgo0tn1kokcc@4ax.com>
References: <IDEJJDGBFBNEKLNKFPAEEEAJCDAA.exilion@yifan.net> <Pine.LNX.4.44.0207051125380.10105-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0207051125380.10105-100000@hawkeye.luckynet.adm>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There has also been a patch on L-K which implments CMOV on prior-PPro
processors. john

On Fri, 5 Jul 2002 11:43:34 -0600 (MDT), Thunder from the hill
<thunder@ngforever.de> wrote:

>Hi,
>
>On Fri, 5 Jul 2002, Pablo Fischer wrote:
>> 1) Its more a HW problem? (a PRocessor problem?) I have AMD K6
>> 
>> 2) So.. you are telling me that I cant solve it? :(, only if I change the
>> proccessor to a Pentium?..
>
>It's a problem with the module code. It should be sufficient to replace 
>cmov with something that can execute on < P6. That means, hand-checking, 
>depending on !CONFIG_MPENTIUM4.
>
>							Regards,
>							Thunder

