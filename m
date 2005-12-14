Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbVLNRCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVLNRCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVLNRCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:02:19 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:30304 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964879AbVLNRCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:02:17 -0500
Message-ID: <43A04FC8.4080104@openvz.org>
Date: Wed, 14 Dec 2005 20:00:56 +0300
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vserver@list.linux-vserver.org
CC: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Vserver] Re: [ANNOUNCE] second stable release of Linux-VServer
References: <20051213185650.GA6466@MAIL.13thfloor.at>	<Pine.LNX.4.63.0512140832200.2723@cuia.boston.redhat.com>	<20051214143819.GB20138@sergelap.austin.ibm.com> <20051214164736.GD6778@MAIL.13thfloor.at>
In-Reply-To: <20051214164736.GD6778@MAIL.13thfloor.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:

>>Additionally, the pid virtualization we've
>>been discussing (and which should be submitted soon) would remove the
>>need for the tasklookup patch, so bsdjail would reduce even further,
>>to network and simple access controls.
>>    
>>
>complete pid virtualization would be interesting for
>migration and checkpointing too (not just isolation
>and security), so I think that might be something of
>interest for a broader audience ...
>  
>
Just to make sure everybody is aware:
pids are already virtualized in OpenVZ.
If you want to look at the code, it is available
from within diff-openvz-ve patch, see
http://ftp.openvz.org/kernel/broken-out/022stab053.1/
