Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVBOXfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVBOXfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVBOXfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:35:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:41358 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261938AbVBOXfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:35:30 -0500
Subject: Re: 2.6.10 on PowerMac9,1 G5 Fan problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ajay Patel <patela@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <90f56e480502151527696ef315@mail.gmail.com>
References: <90f56e480502151527696ef315@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 10:34:38 +1100
Message-Id: <1108510478.13376.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 15:27 -0800, Ajay Patel wrote:
> Hi,
> 
> I have a single processor PowerMac G5 where
> the model property is PowerMac9,1.
> I do have therm_pm72 and I2C_keywest option
> enabled in my config. Still fans are always on.
> 
> Any thermal control driver patch available for this newer G5?

Hi !

Not yet no. This one uses a new chip called the "SMU" that replace both
the old PMU (power management) and the FCU (fan control unit). I don't
know yet how to operate it to drive the fans, there is no open source
darwin driver for it and no infos available from Apple  :(

Hopefully, I'll get an iMac G5 soon, which has a similar chip, so I'll
be able to do some reverse engineering and eventually figure it out.

Ben.


