Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276314AbRI1VRo>; Fri, 28 Sep 2001 17:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276317AbRI1VRe>; Fri, 28 Sep 2001 17:17:34 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:39442 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S276314AbRI1VR0>;
	Fri, 28 Sep 2001 17:17:26 -0400
Date: Fri, 28 Sep 2001 14:12:44 -0700
From: Greg KH <greg@kroah.com>
To: Petr Konecny <pekon@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10: oops and panic in usb-uhci
Message-ID: <20010928141244.C2066@kroah.com>
In-Reply-To: <qwwpu8bigoi.fsf@decibel.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qwwpu8bigoi.fsf@decibel.fi.muni.cz>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 03:33:01PM +0200, Petr Konecny wrote:
> Hi,
> 
> I tried to play a wav on my USB audio speakers (Yamaha YSTMS35D) and got
> panic. The oops (processed by ksymoops) is appended. uhci works OK.

Please use the uhci.o driver or apply the patch found at:
	http://marc.theaimsgroup.com/?l=linux-kernel&m=100159287918217&w=2

thanks,

greg k-h
