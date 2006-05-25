Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWEYKDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWEYKDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWEYKDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:03:07 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:5311 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S965100AbWEYKDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:03:06 -0400
Date: Thu, 25 May 2006 11:03:01 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: dummy@vaio.testbed.de
To: David Mosberger-Tang <David.Mosberger@acm.org>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: trivial videodev2.h patch
In-Reply-To: <ed5aea430605242114g1e51e7e9nb124de50dbbf1e40@mail.gmail.com>
Message-ID: <Pine.NEB.4.64.0605251100500.7762@vaio.testbed.de>
References: <ed5aea430605242114g1e51e7e9nb124de50dbbf1e40@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2006, David Mosberger-Tang wrote:
> linux/videodev2.h uses types such as __u8 but it fails to include
> <linux/types.h>.  Within the kernel, that's not a problem because
> <linux/time.h> already includes <linux/types.h>.  However, there are
> user apps that try to include videodev2.h (e.g., ekiga) and at least

userspace apps should (must?) not include kernel headers, AFAIK.
there is lots of discussion regarding this in the lkml archives...

Christian.
-- 
BOFH excuse #435:

Internet shut down due to maintenance
