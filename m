Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVAOQzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVAOQzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 11:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVAOQzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 11:55:00 -0500
Received: from bromo.msbb.uc.edu ([129.137.3.146]:50156 "HELO
	bromo.msbb.uc.edu") by vger.kernel.org with SMTP id S262299AbVAOQyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 11:54:33 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: usb key oddities with 2.6.10-ac9
Message-Id: <20050115165307.96FDC1DC100@bromo.msbb.uc.edu>
Date: Sat, 15 Jan 2005 11:53:07 -0500 (EST)
From: howarth@bromo.msbb.uc.edu (Jack Howarth)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sami,
    I don't believe that additional change to initscripts could be
the cause because Fedora Core 2 doesn't support udev. Only Fedora
Core 3 implements that feature and there are reports of the same
problem occuring under it with 6.5.10.

http://marc.theaimsgroup.com/?l=linux-usb-users&m=110564343717762&w=2

I did notice that FC3 seems to be using initscripts-7.93.5 which
still uses hotplug instead of udevsend. However it seems odd that
both forms (dev and udev) seemed to have gotten broken in the same
way. I assume one can't use udevsend if the kernel isn't using udev
right?
                Jack
