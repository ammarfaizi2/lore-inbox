Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263485AbRFAMoO>; Fri, 1 Jun 2001 08:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263488AbRFAMoE>; Fri, 1 Jun 2001 08:44:04 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:45855 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S263487AbRFAMn4>; Fri, 1 Jun 2001 08:43:56 -0400
Subject: Re: USB mouse wheel breakage was Re: Linux 2.4.5-ac5
From: Robert "M." Love <rml@tech9.net>
To: Michael <leahcim@ntlworld.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <laughing@shared-source.org>
In-Reply-To: <20010601105717.A2468@debian>
In-Reply-To: <20010601105717.A2468@debian>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 01 Jun 2001 08:43:48 -0400
Message-Id: <991399435.4435.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Jun 2001 10:57:17 +0100, Michael wrote:
> On Wed, May 30, 2001 at 09:30:39PM +0100, Alan Cox wrote:
> > 2.4.5-ac4
> > o   Update USB hid drivers                          (Vojtech Pavlik)
> 
> I think these changes have broken my USB wheel mouse.
> 
> Events seems to be getting lost (/dev/input/mice)
> 
> It only scrolls when either the scroll direction has changed or if other
> mouse events occur (e.g. you need to wiggle mouse from side to side to
> scroll down a long page in mozilla)
> 
> problems seems to be in drivers/usb/hid-core.c hid_input_field line 772

ive noticed the same problem -- mouse movement itself is even jerky, so
i suspect events are being lost.  the mouse is not really even usable
for me in X.

i too traced the problem down to hid-core.c, i think, and i am going to
try to write up a patch against the latest ac, but the Maintainer may
already realize the problem?

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

