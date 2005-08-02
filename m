Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVHBRvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVHBRvi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 13:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVHBRvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 13:51:38 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:38921 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261674AbVHBRvf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 13:51:35 -0400
Message-ID: <42EFB3BB.1060900@tmr.com>
Date: Tue, 02 Aug 2005 13:56:11 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Athul Acharya <aacharya@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Determining if the current processor is Hyperthreaded
References: <5a67a16f05072909245ae1c44c@mail.gmail.com>
In-Reply-To: <5a67a16f05072909245ae1c44c@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Athul Acharya wrote:
> Hey folks,
> 
> Is there a quick way to determine if the current processor is
> Hyperthreaded, and if so, which logical processor represents the other
> thread on the chip? Please cc replies to me as I am not subscribed to
> the list :-)

Look at /proc/cpuinfo and see if "siblings" is listed and more than one. 
There is no "other thread" there, it's like "which one is the other hand?"
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
