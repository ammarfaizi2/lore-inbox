Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263320AbSIPXDv>; Mon, 16 Sep 2002 19:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSIPXDv>; Mon, 16 Sep 2002 19:03:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51979 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263320AbSIPXDu>;
	Mon, 16 Sep 2002 19:03:50 -0400
Message-ID: <3D86645F.5030401@mandrakesoft.com>
Date: Mon, 16 Sep 2002 19:08:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       todd-lkml@osogrande.com, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       netdev@oss.sgi.com, pfeather@cs.unm.edu
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <20020916.154640.78359545.davem@redhat.com>  <20020916.125211.82482173.davem@redhat.com> <Pine.LNX.4.44.0209161528140.13850-100000@gp.staff.osogrande.com> <12116.1032216780@redhat.com> <12293.1032217399@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> davem@redhat.com said:
> 
>>>  Er, surely the same goes for sys_sendfile? Why have a new system
>>>  call rather than just swapping the 'in' and 'out' fds?
>>
> 
>>There is an assumption that one is a linear stream of output (in this
>>case a socket) and the other one is a page cache based file.
> 
> 
> That's an implementation detail and it's not clear we should be exposing it 
> to the user. It's not entirely insane to contemplate socket->socket or 
> file->file sendfile either -- would we invent new system calls for those 
> too? File descriptors are file descriptors.

I was rather disappointed when file->file sendfile was [purposefully?] 
broken in 2.5.x...

	Jeff



