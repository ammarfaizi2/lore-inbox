Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281142AbRKOWkU>; Thu, 15 Nov 2001 17:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281144AbRKOWkB>; Thu, 15 Nov 2001 17:40:01 -0500
Received: from [216.80.8.1] ([216.80.8.1]:27146 "HELO mercury.prairiegroup.com")
	by vger.kernel.org with SMTP id <S281142AbRKOWjs>;
	Thu, 15 Nov 2001 17:39:48 -0500
Message-ID: <3BF44444.7010101@prairiegroup.com>
Date: Thu, 15 Nov 2001 16:40:04 -0600
From: Martin McWhorter <m_mcwhorter@prairiegroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible Bug: 2.4.14 USB Keyboard
In-Reply-To: <20011114145312.A6925@kroah.com> <mailman.1005834780.32418.linux-kernel2news@redhat.com> <200111151807.fAFI7XN30496@devserv.devel.redhat.com> <3BF40D17.4060501@prairiegroup.com> <20011115141430.B10133@devserv.devel.redhat.com> <3BF41E17.5080200@prairiegroup.com> <20011115152432.A26630@devserv.devel.redhat.com> <3BF433EE.40403@prairiegroup.com> <20011115170148.A19715@devserv.devel.redhat.com> <3BF43E55.80401@prairiegroup.com> <20011115171751.A22915@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete,



> Try to rename /sbin/hotplug into something else _temporarily_,

Gave this a try. No luck. Interestingly nothing apperently stopped working.

But I did find something that did. Remove the loading of hid in 
rc.sysinit and add it the the end of rc.local.

Thanks alot Pete,
Martin

