Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265277AbTL0Ab7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 19:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbTL0Ab7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 19:31:59 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:31276 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265277AbTL0Ab6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 19:31:58 -0500
Message-ID: <3FECD2FB.4070008@ntlworld.com>
Date: Sat, 27 Dec 2003 00:31:55 +0000
From: Matt <dirtbird@ntlworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.4-6 StumbleUpon/1.87
X-Accept-Language: en, en-gb, ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you are on debian i have noticed recently that gnomevfs (on unstable) 
requires famd. famd will open /cdrom after it is mounted and run a dir 
notification on it. now i think famd needs some fixing, firstly to not 
bother running dir notice on ro filesystems, and secondly allow an 
authorised user (other than the original program (in this case 
nautilus)) to drop specific mount point dirs from the notification list. 
so yes this is a userland problem as far as i can see.

    matt


