Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbUJ1Wl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbUJ1Wl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUJ1Wkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:40:52 -0400
Received: from web52801.mail.yahoo.com ([206.190.39.165]:18365 "HELO
	web52801.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263041AbUJ1Wfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:35:52 -0400
Message-ID: <20041028223552.71331.qmail@web52801.mail.yahoo.com>
Date: Thu, 28 Oct 2004 23:35:52 +0100 (BST)
From: Mehul Patel <mehuljpatel@yahoo.com>
Subject: Exclusive access to hardware for test purpose
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is anyone aware of kernel call which allows a test
tool developer to have exclusive access to PCI adapter
hardware. By exclusive access I mean both
driver as well as kernel should not touch hardware. 

I have been using driver's remove call to simulate the
situation as if adapter has been hot plugged out. And
once my testing is done I call driver's probe
call to put adapter back. But this seems to create a
problem when somehow kernel calls driver's remove
call.

Also If I dont call probe for the removed adapter, on
next reboot machine hangs !

Any information/suggestions please .....

Thanks in advance.

best regards,
Mehul.

Send instant messages to your online friends http://uk.messenger.yahoo.com 
