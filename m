Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265022AbUEYSWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbUEYSWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbUEYSUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:20:18 -0400
Received: from hyperion.haystack.edu ([192.52.65.1]:54990 "EHLO
	hyperion.haystack.edu") by vger.kernel.org with ESMTP
	id S265022AbUEYSSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:18:43 -0400
Message-ID: <40B38DFD.1080608@haystack.mit.edu>
Date: Tue, 25 May 2004 14:18:37 -0400
From: Frank Lind <flind@haystack.mit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: knobi@knobisoft.de
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Multicast problems between 2.4.20 and 2.4.21?
References: <20040525181510.68862.qmail@web13902.mail.yahoo.com>
In-Reply-To: <20040525181510.68862.qmail@web13902.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

/sbin/sysctl -w net.ipv4.conf.eth1.force_igmp_version=2

the above worked for me. I think it was added in 2.4.25 and 2.6.2.

-- Frank


Martin Knoblauch wrote:

>--- "David S. Miller" <davem@redhat.com> wrote:
>  
>
>>You don't need a patch to force IGMPv2, there is a sysctl
>>available now in 2.4.x for this purpose.
>>
>>
>>    
>>
>David,
>
>  what is the name of the sysctl, and when was it added to 2.4? What
>about 2.6.x?
>
>Thanks
>Martin
>
>=====
>------------------------------------------------------
>Martin Knoblauch
>email: k n o b i AT knobisoft DOT de
>www:   http://www.knobisoft.de
>
>!DSPAM:40b38d3220961361122433!
>
>
>  
>


-- 
Frank D. Lind			email: flind@haystack.mit.edu	
MIT Haystack Observatory	WWW: http://www.haystack.mit.edu
Route 40			tel: 781 981 5570
Westford, MA  01886  USA	fax: 781 981 5766



