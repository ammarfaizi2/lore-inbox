Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTIDAtp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 20:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTIDAtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 20:49:45 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:40453 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264450AbTIDAto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 20:49:44 -0400
Date: Thu, 4 Sep 2003 02:49:41 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Aaron Dewell <acd@woods.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: partition weirdness
Message-ID: <20030904024941.A2658@pclin040.win.tue.nl>
References: <Pine.LNX.4.44.0309031758140.385-100000@dragon.woods.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309031758140.385-100000@dragon.woods.net>; from acd@woods.net on Wed, Sep 03, 2003 at 06:07:52PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 06:07:52PM -0600, Aaron Dewell wrote:

> The problem is this:  the partition table is recognized, but the individual
> partitions (the ones I care about) are zero, that is to say, they contain the
> right size of zeros.  The disk device itself, at the partition table boundaries,
> is not zero, and I can't explain this discrepency.  On the disk, there seem to be
> correct and valid superblocks at the right places, they just don't exist in the
> partition devices.

Does the kernel have support for sun partition tables built in?
What are the kernel boot messages about the disk?
What does /proc/partitions say?
What does fdisk -l say?

