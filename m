Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264752AbUD1L4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264752AbUD1L4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 07:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264758AbUD1L4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 07:56:21 -0400
Received: from CPE-139-168-157-129.nsw.bigpond.net.au ([139.168.157.129]:41981
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S264752AbUD1L4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 07:56:20 -0400
Message-ID: <408F9BD8.8000203@eyal.emu.id.au>
Date: Wed, 28 Apr 2004 21:56:08 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.6-rc3
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> s390, cifs, ntfs, ppc, ppc64, cpufreq upates. Oh, and DVB and USB.
> 
> I'm hoping to do a final 2.6.6 later this week, so I'm hoping as many 
> people as possible will test this.

OK, I'll bite. Building using :
	# gcc --version
	2.95.4

depmod says:

WARNING: /lib/modules/2.6.6-rc3/kernel/drivers/media/dvb/frontends/tda1004x.ko needs unknown symbol errno
WARNING: /lib/modules/2.6.6-rc3/kernel/drivers/media/video/cx88/cx8800.ko needs unknown symbol __ucmpdi2

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
