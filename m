Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUCRBAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 20:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUCRBAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 20:00:51 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:46935 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262272AbUCRBAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 20:00:41 -0500
Message-ID: <4058F4B8.5050304@blueyonder.co.uk>
Date: Thu, 18 Mar 2004 01:00:40 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Need help about scanner (2.6.2-mm1)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Mar 2004 01:00:40.0720 (UTC) FILETIME=[6ECA8900:01C40C84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Azog wrote:
 > Thank you so much for the tip! This seems to have solved my problem
 > too.

 > I changed my epson.conf file to just say
 > "usb"
 > instead of
 > "usb /dev/usb/scanner0"

 > and now, finally, it works. I do hope the SANE documentation writers
 > get around to adding that little tidbit of info SOMEWHERE, I was
 > tearing my hair out and rebooting back to 2.4 to use my scanner.

I tried that in 2.6.5-rc1-mm1, restarted sane, but it still fails. 
scanimage -L does not find the scanner, sane-find-scanner finds it, but 
says I have scsi modules loaded, even though I've rmmod them. I'm using 
a recent CVS libusb and sane.
I found an article on linuxtoday.com that pointed me to vuescan where I 
downloaded their initial linux release and the scanner (Epson USB 610) 
works fine using it. It uses the libusb-0.1.so.4.4.1 I have installed, 
so that points back to a problem with sane which I have added to their 
bug list.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

