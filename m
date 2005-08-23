Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVHXBGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVHXBGg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 21:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVHXBGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 21:06:36 -0400
Received: from intranet.networkstreaming.com ([24.227.179.66]:44732 "EHLO
	networkstreaming.com") by vger.kernel.org with ESMTP
	id S1750704AbVHXBGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 21:06:36 -0400
Message-ID: <430B5802.5050200@davyandbeth.com>
Date: Tue, 23 Aug 2005 12:08:18 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Willy Tarreau <willy@w.ods.org>, bert hubert <bert.hubert@netherlabs.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: select() efficiency / epoll
References: <42E162B6.2000602@davyandbeth.com> <20050722212454.GB18988@outpost.ds9a.nl> <430AF11A.5000303@davyandbeth.com> <20050823182405.GA21301@outpost.ds9a.nl> <430B01FB.2070903@davyandbeth.com> <20050823191254.GB10110@alpha.home.local> <430B077A.10700@davyandbeth.com> <20050823194557.GC10110@alpha.home.local> <430B0EAE.9080504@davyandbeth.com> <20050823202018.GA28724@alpha.home.local> <Pine.LNX.4.63.0508231618420.7257@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.63.0508231618420.7257@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2005 01:06:11.0875 (UTC) FILETIME=[04A1C730:01C5A848]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>
> I should mention that the 2.4 patch is old WRT mainline epoll in 2.6 
> (I stopped maintaining it when 2.6 went "stable"). I'd definitely 
> suggest to use 2.6 if you are looking at epoll.
>
I am using linux-2.6.11 and glibc-2.3.4  .. and using select() in it's 
place seems to work fine.  Are there any known issues with say, one 
thread does epoll_wait()s while other threads may be doing epoll_ctl()s?

Is there someone else I should be asking this question?

Thanks,
  Davy
