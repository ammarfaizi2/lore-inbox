Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTLYFLs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 00:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTLYFLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 00:11:48 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:61676 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262745AbTLYFLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 00:11:48 -0500
Message-ID: <3FEA7192.6020004@blueyonder.co.uk>
Date: Thu, 25 Dec 2003 05:11:46 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hotplug and 2.6.0-mm1 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Dec 2003 05:12:00.0049 (UTC) FILETIME=[A0128A10:01C3CAA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get failures with hotplug on SuSE 9.0 and found out it is expecting 
/proc/bus/usb/drivers/ to exist. Modding /etc/hotplug/usb.rc to point to 
/sys/bus/usb/drivers/ does not fix it.
Downloaded and built hotplug-2003_08_05.tar.gz (latest I could find), 
but the file looks just the same and I'm getting "hotplug: can't 
synthesize events" messages.
Is there a 2.6.0 hotplug to be had?
Regards
Sid.
-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.
