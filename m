Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSIQXg4>; Tue, 17 Sep 2002 19:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264675AbSIQXg4>; Tue, 17 Sep 2002 19:36:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45188 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264625AbSIQXg4>;
	Tue, 17 Sep 2002 19:36:56 -0400
Date: Tue, 17 Sep 2002 16:32:46 -0700 (PDT)
Message-Id: <20020917.163246.113965700.davem@redhat.com>
To: johnstul@us.ibm.com
Cc: jamesclv@us.ibm.com, ak@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1032305535.7481.204.camel@cog>
References: <200209171555.52872.jamesclv@us.ibm.com>
	<20020917.161215.03597459.davem@redhat.com>
	<1032305535.7481.204.camel@cog>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: john stultz <johnstul@us.ibm.com>
   Date: 17 Sep 2002 16:32:15 -0700
   
   Additionally, where is this system tick thing? You make it sound like
   its a register in the cpu, and while the Ultra-III may have one, I'm
   unaware of a system/bus tick register on intel chips. Is it in some
   semi-documented MSR?

It's in a register on Ultra-III.  The whole point of this
conversation, if you read my initial postings, is that
"this should have been specified in the x86 architecture"

I know full well it isn't currently :-)
