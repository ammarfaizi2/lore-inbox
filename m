Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTKNIEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 03:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTKNIEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 03:04:21 -0500
Received: from hibernia.jakma.org ([213.79.33.168]:31622 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S261605AbTKNIET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 03:04:19 -0500
Date: Fri, 14 Nov 2003 08:04:08 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [RFCI] How best to partition MD/raid devices in 2.6
In-Reply-To: <16308.18387.142415.469027@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.56.0311140801030.22888@fogarty.jakma.org>
References: <16308.18387.142415.469027@notabene.cse.unsw.edu.au>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, 14 Nov 2003, Neil Brown wrote:

>  4/ just use 'dm', or write a new 'md' module that can present a
>     partition of a device.  Then leave the setup to user-space.
>     This is least impact on the kernel, but most impact on
>     user-space.  It would not be too hard to create a userspace tool

>From a user/admin POV, I'd say go with dm. Even the 'virt-partition
by way of dm' isnt needed if you have LVM tools, but I guess might be
nice to obviate need for extra tools. (though, I couldnt live without
LVM anymore, its just /too/ useful.).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
It is against the law for a monster to enter the corporate limits of
Urbana, Illinois.
