Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992786AbWJUCOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992786AbWJUCOH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 22:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992790AbWJUCOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 22:14:07 -0400
Received: from ns.suse.de ([195.135.220.2]:19093 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S2992786AbWJUCOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 22:14:04 -0400
From: Andi Kleen <ak@suse.de>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.19-rc2-mm2
Date: Sat, 21 Oct 2006 04:13:40 +0200
User-Agent: KMail/1.9.3
Cc: artusemrys@sbcglobal.net, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
       akpm@osdl.org
References: <20061020015641.b4ed72e5.akpm@osdl.org> <p734ptybk0z.fsf@verdi.suse.de> <20061021005014.GC12131@kroah.com>
In-Reply-To: <20061021005014.GC12131@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610210413.40401.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yeah, real numbers would be good to have.  I have measured 7-8 seconds
> off the boot on my workstation, and 2 seconds off the boot for my
> laptop.  All of the time saved seems to be due to slow SATA startup
> times, and the machine is off initializing other things while that is
> happening.

So perhaps it would be a safer strategy to just run the SATA probing in the
background and keep the rest serialized? 

-Andi
