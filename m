Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUIWVIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUIWVIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUIWVIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:08:04 -0400
Received: from outmx004.isp.belgacom.be ([195.238.2.101]:40668 "EHLO
	outmx004.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S267186AbUIWVG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:06:27 -0400
Message-ID: <415339D3.2080206@skynet.be>
Date: Thu, 23 Sep 2004 23:02:11 +0200
From: Madnux <madnux@skynet.be>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x ( unable to open an initial console & unable to mount devfs,
 err: -5 )
References: <4151E749.7060107@skynet.be> <47612A96-0CDB-11D9-BC62-000D9352858E@linuxmail.org>
In-Reply-To: <47612A96-0CDB-11D9-BC62-000D9352858E@linuxmail.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry but i'm not running udev !

I've run /sbin/MAKEDEV but it doesn't work anymore.

I still get "Unable to open an initial console"


I don't understand what's wrong ...




Felipe Alfaro Solana a écrit :

 > On Sep 22, 2004, at 22:57, Madnux wrote:
 >
 >> Hello,
 >>
 >>
 >> I have some problems with my kernel 2.6.7 and 2.6.8.1.
 >>
 >> I get this message « mount_devfs_fs(): unable to mount devfs, err: 
-5 » and then « unable to open an initial console » What's this ? What 
does « err: -5 » mean ?
 >>
 >> I tried with no devfs compiled in but i still have this error 
message « unable to open an initial console »
 >>
 >> Fortunatly, i had kept my old kernel ( 2.4.20 ) who have no devfs 
compiled in and it run very well for 7 months
 >>
 >>
 >> What's wrong with my system ?? Did i forget an option in the 
compilation ?
 >>
 >>
 >> I have looked everywhere about that problem until monday !
 >
 >
 >
 > I think you are running one of the latest udev snapshots from 
RawHide, and it erased some important device nodes from your "/dev" 
directory. I guess you'll need to run /sbin/makedev to recreate the 
missing devices files.


