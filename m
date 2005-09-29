Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVI2TV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVI2TV4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVI2TV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:21:56 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:41331 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932355AbVI2TVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:21:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=1WYzb7qCzXUtI1qQnm+8SQSE2AzSjNVG2weQN084nNhMw788gg8+riuHr4qtV5N6A2FdKxYzX0m6HnDlVJ68ANEriHay2Grkc6OJF48QBvRia9Z+LOzGsrFgOHpRl5ewc58z2WFur2tlLTqP8SLnNmiwCbCWYV5uERvLxKFQ5Ew=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: [2.6.14] Cpufreq_ondemand sysfs names change
Date: Thu, 29 Sep 2005 14:03:48 +0200
User-Agent: KMail/1.8.2
Cc: Dave Jones <davej@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       Alexander Clouter <alex@digriz.org.uk>, Andrew Morton <akpm@osdl.org>
References: <200508232108.26248.blaisorblade@yahoo.it> <200509271851.36706.blaisorblade@yahoo.it> <433BABA9.8070908@suse.de>
In-Reply-To: <433BABA9.8070908@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509291403.48892.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 September 2005 10:54, Stefan Seyfried wrote:
> Blaisorblade wrote:
> > *) to rename the flag to ignore_nice_load or ignore_nice_tasks, to avoid
> > burning the user too much. Very few people use it now, but let's help
> > them.

> I use it and i have even "fixed" my applications to use the "wrong" flag.
Me too, but it's a trivial script in my case.
> >> My thinking too, its a relatively new feature and when I have looked
> >> around very few userland tools even tinker with ondemand so either we do
> >> it now or not at all...or rather we do it later and listen to everyone
> >> complain :)

> so the early birds are doomed? ;-)
> I'll bite the bullet if this "flip the meaning" gets in, but i don't
> like it. I'll have to check for the kernel version in my userspace code,
> then which is generally a bad idea IMO.

That's why I proposed renaming the sysfs file, and then you can test with 
"test -f" (in bash).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
