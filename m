Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755764AbWK0NFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764AbWK0NFf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 08:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758181AbWK0NFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 08:05:35 -0500
Received: from paragon.brong.net ([66.232.154.163]:735 "EHLO paragon.brong.net")
	by vger.kernel.org with ESMTP id S1755764AbWK0NFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 08:05:34 -0500
Date: Tue, 28 Nov 2006 00:05:18 +1100
From: Bron Gondwana <brong@fastmail.fm>
To: erich <erich@areca.com.tw>
Cc: Maurice Volaski <mvolaski@aecom.yu.edu>,
       =?utf-8?B?KOW7o+WuieenkeaKgCnomIfojonltZA=?= <lusa@areca.com.tw>,
       =?utf-8?B?KOW7o+WuieenkeaKgCnnvoXku7vlgYk=?= 
	<robert.lo@areca.com.tw>,
       =?utf-8?B?KOW7o+WuieenkeaKgCnnjovlrrbku7I=?= <kevin34@areca.com.tw>,
       support@areca.com.tw, linux-kernel@vger.kernel.org
Subject: Re: Pathetic write performance from Areca PCIe cards
Message-ID: <20061127130518.GC7610@brong.net>
References: <a06240400c18e4b03eadf@[129.98.90.227]> <00f501c711d4$f04c7530$b100a8c0@erich2003>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f501c711d4$f04c7530$b100a8c0@erich2003>
Organization: brong.net
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 11:34:23AM +0800, erich wrote:
> Dear Maurice Volaski,
> 
> Please update Areca Firmware version into 1.42.
> Areca's firmware team found some problems on high capacity transfer.
> Hope the weird  phenomenon should disappear.

Erich, is there anyone at Areca that you can pass on the message to

       +--------------------------------------------+
       | Please update your ftp server/website when |
       | there is a new firmware or driver release! |
       +--------------------------------------------+

that would be great.  I followed the links from www.areca.us to the
firmware at:

ftp://ftp.areca.com.tw/RaidCards/BIOS_Firmware/ARC1130/

for our cards, but the 1210 and 1220 that Maurice was speaking about
suffer from the same problem - there is no mention of a 1.42 firmware
anywhere, just the 1.41 that's been out for ages.

...


And speaking of 1.41, there appear to have been two releases on two
different dates both called 1.41, as well as two different versions
of the driver that both call themselves version 1.41 despite the
second one fixing a major bug we suffered from.

Please also avoid that behaviour and label each new version of
the driver with a new number if you're using version numbers.

Numbers are cheap, but identifying if a machine is running the patches
it needs to not crash every few weeks under the loads we run them at 
is not (well, not until it crashes anyway!)


Thanks for listening, and hopefully thanks in advance for making your
drivers and firmware easier to find and identify in future.

Regards,

Bron.
