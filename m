Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130138AbRB1MAy>; Wed, 28 Feb 2001 07:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130139AbRB1MAn>; Wed, 28 Feb 2001 07:00:43 -0500
Received: from smtp-rt-5.wanadoo.fr ([193.252.19.159]:55213 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130138AbRB1MAc>; Wed, 28 Feb 2001 07:00:32 -0500
Message-ID: <3A9CE7F6.2000202@wanadoo.fr>
Date: Wed, 28 Feb 2001 12:58:46 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en, fr-fr
MIME-Version: 1.0
To: Glenn McGrath <bug1@optushome.com.au>
CC: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: devfs and /proc/ide/hda
In-Reply-To: <3A9CCA76.3E6AB93A@optushome.com.au> <3A9CD2F3.E26A2884@idb.hist.no> <3A9CD304.26C3A568@optushome.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glenn McGrath wrote:

> Helge Hafting wrote:
> 
>> Glenn McGrath wrote:
>> 
>>> Im running kernel 2.4.1, I have entries like /proc/ide/hda,
>>> /proc/ide/ide0/hda etc irrespective of wether im using devfs or
>>> traditional device names.
>>> 
>>> Is always using traditional device names for /proc/ide intentional, or
>>> is it something nobody has gotten around to fixing yet?
>> 
>> Using devfs changes the names in /dev.  I don't think it
>> is supposed to affect /proc in any way.  And there are programs out
>> that use the existing /proc - changing it won't be popular.
>> 
> 
> 
> Well leaving it the way it is doesnt make much sense either really, it
> refers to devices that dont exist.

IMHO ide0 ide1... are naming plugs on the motherboard. They are not
competing with special file names. It is a drawback of devfs to change
the device name when you happen to use a hd as a removable media.
hdd was disc0 and becomes disc1 when you plug in an hda...

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

