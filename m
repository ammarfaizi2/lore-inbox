Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279591AbRJXUkd>; Wed, 24 Oct 2001 16:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279589AbRJXUkZ>; Wed, 24 Oct 2001 16:40:25 -0400
Received: from james.kalifornia.com ([208.179.59.2]:42839 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S279591AbRJXUkT>; Wed, 24 Oct 2001 16:40:19 -0400
Message-ID: <3BD7263A.9020100@blue-labs.org>
Date: Wed, 24 Oct 2001 16:36:10 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011022
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortelnetworks.com>, kuznet@ms2.inr.ac.ru
CC: Julian Anastasov <ja@ssi.bg>, Tim Hockin <thockin@sun.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: issue: deleting one IP alias deletes all
In-Reply-To: <Pine.LNX.4.33.0110240042570.1210-100000@u.domain.uli> <3BD65188.1060203@blue-labs.org> <3BD6CA13.613B22EE@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That is IMO bad behavior, it didn't use to do this because I have 
scripts that rely on this behavior.

I'll take it up with the author, Alexey.

David

Christopher Friesen wrote:

David Ford wrote:

>Actually it is quite sane.  The tool is not.
>
>Switch to 'ip' instead of 'ifconfig', several large distros now include
>it.  Addresses can be added and removed completely indiscriminately on
>interfaces.
>
>The "ethN:X" is a legacy design that is now deprecated.
>

Minor issue...if I create (using 'ip') two addresses on the same subnet on the
same device, one of them is primary and the other is secondary.  If I then
delete the primary address, the second one goes with it.

I submit that this is bad behaviour.

Chris




