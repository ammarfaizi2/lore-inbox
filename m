Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbWEYVoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbWEYVoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWEYVoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:44:16 -0400
Received: from main.gmane.org ([80.91.229.2]:13020 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030445AbWEYVoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:44:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH] Add compile domain
Date: Thu, 25 May 2006 22:43:27 +0100
Message-ID: <yw1xodxlwzk0.fsf@agrajag.inprovide.com>
References: <20060525141714.GA31604@skunkworks.cabal.ca> <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org> <200605251954.06227.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0605252100070.13379@yvahk01.tjqt.qr> <44761E38.7050702@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: agrajag.inprovide.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
Cancel-Lock: sha1:Ym0qE0WHj+B/LC6Yv+rvbyhR778=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> writes:

>> 20:35 mason:/etc # rpm -qf `which hostname`
>> net-tools-1.60-37
>> 21:00 mason:/etc # hostname -v
>> gethostname()=`mason'
>> mason
>> 21:00 mason:/etc # hostname --fqdn
>> mason
>> 21:00 mason:/etc # domainname
>> (none)
>> 21:00 mason:/etc # dnsdomainname
>> Runs Aurora Linux 2.0.
>
> Ubuntu does this too:
>
> mbligh@flay:~$ hostname
> flay
> mbligh@flay:~$ hostname --fqdn
> localhost.localdomain

Gentoo:

mru@agrajag:~$ hostname
agrajag
mru@agrajag:~$ hostname --fqdn
agrajag.inprovide.com
mru@agrajag:~$ hostname --version
net-tools 1.60
hostname 1.100 (2001-04-14)

-- 
Måns Rullgård
mru@inprovide.com

