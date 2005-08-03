Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVHCSIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVHCSIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 14:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVHCSIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 14:08:47 -0400
Received: from bee.hiwaay.net ([216.180.54.11]:42312 "EHLO bee.hiwaay.net")
	by vger.kernel.org with ESMTP id S262385AbVHCSIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 14:08:44 -0400
Date: Wed, 3 Aug 2005 13:08:35 -0500
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Cc: Simon Matter <simon.matter@invoca.ch>
Subject: Re: File corruption on LVM2 on top of software RAID1
Message-ID: <20050803180835.GA1043467@hiwaay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa.joi2dm7.1l4o8in@ifi.uio.no>
User-Agent: Mutt/1.4i
X-Newsgroups: fa.linux.kernel
Organization: HiWAAY Internet Services
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, "Simon Matter" <simon.matter@invoca.ch> said:
>In my tests I get corrupt files on LVM2 which is on top of software raid1.
>(This is a common setup even mentioned in the software RAID HOWTO and has
>worked for me on RedHat 9 / kernel 2.4 for a long time now and it's my
>favourite configuration). Now, I tested two different distributions, three
>kernels, three different filesystems and three different hardware. I can
>always reproduce it with the following easy scripts:

See:

http://bugzilla.kernel.org/show_bug.cgi?id=4946
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=152162

There's a one-line patch in there; see if that fixes the problem for
you.

-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
