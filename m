Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUAYSVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 13:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265167AbUAYSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 13:21:51 -0500
Received: from APastourelles-108-2-1-3.w80-14.abo.wanadoo.fr ([80.14.139.3]:29701
	"EHLO samwise.two-towers.net") by vger.kernel.org with ESMTP
	id S265163AbUAYSVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 13:21:50 -0500
Message-ID: <4014091D.1060509@two-towers.net>
Date: Sun, 25 Jan 2004 19:21:17 +0100
From: Philip Dodd <phil.lists@two-towers.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Mongenet <Marc.Mongenet@freesurf.ch>
CC: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.25pre7 - cannot mount 128MB vfat fs on Minolta camera
References: <4013D155.3080900@freesurf.ch> <87y8rw2eyy.fsf@devron.myhome.or.jp> <40140221.40901@freesurf.ch>
In-Reply-To: <40140221.40901@freesurf.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Mongenet wrote:
8<
 >
 > Well, 10 minutes after finally reporting the problem, I discovered that
 > it is different than described above...
 >
 > So, I can mount the 16 MB card or the 128 MB card with any kernel,
 > BUT I have to reboot the system when I change the cards. Example:
8<

I have some faint recollections of when I was using USB mass storage 
camera media.  Look into a package called scsiadd; which can be used to 
rescan the bus and add/remove devices on the fly.

http://llg.cubic.org/tools/ is what google brings me up.

I think this will help you - you'll need to rescan the USB mass-storage 
bus - remove/add devices when you change the parameters of a device. 
It's quite easy, I cobbled together a little shell script that would 
remove add the device then mount it.  I used that script to mount the 
USB card instead of mount - meant that I was sure the scsiadd stuff was 
handled if needed.

I think this will help you work around having to reboot.

rgds,

Phil

-- 
()  ascii ribbon campaign - against html mail
/\                        - against microsoft attachments

