Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275133AbRIYRm3>; Tue, 25 Sep 2001 13:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275132AbRIYRmU>; Tue, 25 Sep 2001 13:42:20 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:61113 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S275131AbRIYRmD>; Tue, 25 Sep 2001 13:42:03 -0400
Message-ID: <3BB0C0D2.7070805@antefacto.com>
Date: Tue, 25 Sep 2001 18:37:22 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: William Scott Lockwood III <thatlinuxguy@hotmail.com>,
        Nerijus Baliunas <nerijus@users.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: all files are executable in vfat
In-Reply-To: <Pine.GSO.4.21.0109251332470.24321-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

>On Tue, 25 Sep 2001, William Scott Lockwood III wrote:
>
>>dmask?
>>
>Umm... That makes sense.
>

Would make things more complicated though?
Maybe by default (v)fat permissions should be
a+x  on directories and a-x on files. But then
you can't execute any files on (v)fat partitions,
which is equivalent to the noexec option, so I'm
guessing the noexec option was previously overloaded to
do a-x on files so this would be explicit? Maybe
is would be better to put back the old logic? :-)

Padraig.

