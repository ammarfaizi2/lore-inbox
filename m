Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUIVH1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUIVH1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 03:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUIVH1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 03:27:07 -0400
Received: from styx.suse.cz ([82.119.242.94]:33674 "EHLO shadow.suse.cz")
	by vger.kernel.org with ESMTP id S261169AbUIVH1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 03:27:05 -0400
Date: Wed, 22 Sep 2004 09:27:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Lenz <lenz@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new class for led devices
Message-ID: <20040922072727.GA4553@ucw.cz>
References: <1095829641l.11731l.0l@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095829641l.11731l.0l@hydra>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 05:07:21AM +0000, John Lenz wrote:

> This is an attempt to provide an alternative to the current arm  
> specific led interface that is generic for all arches and uses the "one  
> value, one file" idea of sysfs.
> 
> I removed the function attribute that was in the previous patch, and  
> added the ability for userspace to control the timer on each led  
> individually.  Userspace can also set the delay in milliseconds for the  
> blink.

Well, we already have an interface for setting LEDs through the input
layer, it'd be trivial to create an input device driver with just LEDs
and no buttons/keys ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
