Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131293AbRCWRsU>; Fri, 23 Mar 2001 12:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131318AbRCWRsJ>; Fri, 23 Mar 2001 12:48:09 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:64418 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S131293AbRCWRsA>; Fri, 23 Mar 2001 12:48:00 -0500
Message-ID: <3ABB8BDD.60409@muppetlabs.com>
Date: Fri, 23 Mar 2001 09:46:05 -0800
From: Amit D Chaudhary <amit@muppetlabs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
CC: lermen@fgan.de, linux-kernel@vger.kernel.org
Subject: Re: /linuxrc query
In-Reply-To: <3ABAEED2.6020708@muppetlabs.com> <20010323075107.Q3932@almesberger.net> <3ABAF49B.9080109@muppetlabs.com> <20010323121824.R3932@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:

> Amit D Chaudhary wrote:
>> But other information in the 
>> initrd.txt mentions otherwise, hence the query here.
> 
> 
> Hmm, sounds like a bug. Where did you find this ?
I quote from the version in linux-2.4.2-ac22
"
Now, the initrd can be unmounted and the memory allocated by the RAM
disk can be freed:

# umount /initrd
# blockdev --flushbufs /dev/ram0    # /dev/rd/0 if using devfs
"

I guess I assumed the above has to be put in /linuxrc as it follows other 
commands which do go in the /linuxrc. The assumption is not quite correct as I 
have since found out.

Regards
Amit


