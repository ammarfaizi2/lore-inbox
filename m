Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129075AbRBNRkF>; Wed, 14 Feb 2001 12:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbRBNRjr>; Wed, 14 Feb 2001 12:39:47 -0500
Received: from marine.sonic.net ([208.201.224.37]:49276 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S129075AbRBNRj1>;
	Wed, 14 Feb 2001 12:39:27 -0500
X-envelope-info: <dhinds@sonic.net>
Message-ID: <20010214093859.B20503@sonic.net>
Date: Wed, 14 Feb 2001 09:38:59 -0800
From: David Hinds <dhinds@sonic.net>
To: Andrew Morton <andrewm@uow.edu.au>,
        Manfred Spraul <manfred@colorfullife.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] network driver updates
In-Reply-To: <Pine.LNX.3.96.1010214020707.28011E-100000@mandrakesoft.mandrakesoft.com> <3A8A7159.AF0E6180@colorfullife.com> <3A8A8937.A77BA18D@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A8A8937.A77BA18D@uow.edu.au>; from Andrew Morton on Thu, Feb 15, 2001 at 12:33:43AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2001 at 12:33:43AM +1100, Andrew Morton wrote:
> 
> > * something is wrong in the vortex initialization: I don't have such a
> > card, but the driver didn't return an error message on insmod. I'm not
> > sure if my fix is correct.
> 
> That was intentional - dhinds suggested that if the hardware
> isn't present the driver should float about in memory anyway.

Say the driver is linked into the kernel.  Hot plug drivers should not
all complain about not finding their hardware.

-- Dave
