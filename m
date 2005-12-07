Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbVLGVzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbVLGVzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbVLGVzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:55:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30956 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030377AbVLGVzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:55:10 -0500
Date: Wed, 7 Dec 2005 22:52:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][mm] swsusp: limit image size
Message-ID: <20051207215256.GI2772@elf.ucw.cz>
References: <200512072246.06222.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512072246.06222.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 07-12-05 22:46:05, Rafael J. Wysocki wrote:
> Hi,
> 
> The following patch limits the size of the suspend image to approx. 500 MB,
> which should improve the overall performance of swsusp on systems with
> more than 1 GB of RAM.
> 
> It introduces the constant IMAGE_SIZE that can be set to the preferred size
> of the image (in MB) and modifies the memory-shrinking part of
> swsusp to take this constant into account (500 is the default value
> of IMAGE_SIZE).
> 
> Please apply (Pavel, please ack if that's ok).

ACK.

-- 
Thanks, Sharp!
