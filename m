Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263536AbRFAS2f>; Fri, 1 Jun 2001 14:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263395AbRFAS2Z>; Fri, 1 Jun 2001 14:28:25 -0400
Received: from patan.Sun.COM ([192.18.98.43]:47572 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S263536AbRFAS2U>;
	Fri, 1 Jun 2001 14:28:20 -0400
Message-ID: <3B17DF10.8478F0A1@sun.com>
Date: Fri, 01 Jun 2001 11:29:36 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for real 
 this  time)
In-Reply-To: <200106010409.f5149rl25342@devserv.devel.redhat.com> <200106010657.f516vmx11933@www.hockin.org> <20010601044320.A16582@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

> > i2c is only in our stuff because the i2c core is not in the standard kernel
> > yet.  As soon as it is, I will make cobalt_i2c* go away.
> 
> I am puzzled by this comment. Did you look into drivers/i2c/?
> It certainly is a part of a stock kernel. The main user is
> the V4L, in drivers/media/video, but I think LM sensors use it too.

sorry, I meant to say:  The core is in, but the drivers for the adapters in
question are not.  They are part of lm_sensors, and as such, make it very
hard for us to maintain.  I have encouraged the lm_sensors crew to get at
LEAST the adapters/algorithms submitted for general inclusion.  Once that
is in, I will make cobalt_i2c go away.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
