Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263422AbRFAInk>; Fri, 1 Jun 2001 04:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263421AbRFAIna>; Fri, 1 Jun 2001 04:43:30 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:654 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263416AbRFAInW>; Fri, 1 Jun 2001 04:43:22 -0400
Date: Fri, 1 Jun 2001 04:43:20 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for real this  time)
Message-ID: <20010601044320.A16582@devserv.devel.redhat.com>
In-Reply-To: <200106010409.f5149rl25342@devserv.devel.redhat.com> <200106010657.f516vmx11933@www.hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106010657.f516vmx11933@www.hockin.org>; from thockin@hockin.org on Thu, May 31, 2001 at 11:57:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Tim Hockin <thockin@hockin.org>
> Date: Thu, 31 May 2001 23:57:48 -0700 (PDT)

> > i2c framework is not used, I wonder why. Someone thought that
> > it was too heavy perhaps? If so, I disagree.
> 
> i2c is only in our stuff because the i2c core is not in the standard kernel
> yet.  As soon as it is, I will make cobalt_i2c* go away.

I am puzzled by this comment. Did you look into drivers/i2c/?
It certainly is a part of a stock kernel. The main user is
the V4L, in drivers/media/video, but I think LM sensors use it too.

-- Pete
