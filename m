Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269740AbRHDBV2>; Fri, 3 Aug 2001 21:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269744AbRHDBVS>; Fri, 3 Aug 2001 21:21:18 -0400
Received: from weta.f00f.org ([203.167.249.89]:14480 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269740AbRHDBVK>;
	Fri, 3 Aug 2001 21:21:10 -0400
Date: Sat, 4 Aug 2001 13:21:59 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Mark Atwood <mra@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How does "alias ethX drivername" in modules.conf work?
Message-ID: <20010804132159.F18108@weta.f00f.org>
In-Reply-To: <m33d78de7d.fsf@flash.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33d78de7d.fsf@flash.localdomain>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 02:29:58PM -0700, Mark Atwood wrote:

    Is it some "magic" in depmod / modprobe? And how is the network
    interface identifier then passed into the module when it loads?
    
    A nice whitepaper or doc or a few pointers or handholding would be
    apprecated.

the kernel calls modprobe asking for the network device 'eth0',
modprobe uses the configuration file to map this to a module



  --cw
