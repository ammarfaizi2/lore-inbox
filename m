Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267595AbTBREaP>; Mon, 17 Feb 2003 23:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267597AbTBREaP>; Mon, 17 Feb 2003 23:30:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15118 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267595AbTBREaO>;
	Mon, 17 Feb 2003 23:30:14 -0500
Message-ID: <3E51B914.7040207@pobox.com>
Date: Mon, 17 Feb 2003 23:39:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Louis Zhuang <louis.zhuang@linux.co.intel.com>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RESEND] PCI code cleanup
References: <Pine.LNX.4.44.0302172055060.5217-100000@chaos.physics.uiowa.edu> <1045539216.1018.6.camel@hawk.sh.intel.com>
In-Reply-To: <1045539216.1018.6.camel@hawk.sh.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wow, looks pretty good to me.

I was too lazy to check, but you may want to be careful of:
list iteration direction.  IIRC there were some list traversals that 
happened in reverse order, and you don't want to accidentally change 
that in the cleanup.  I'm not saying you did... just that is something 
to check.

