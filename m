Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVBCGp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVBCGp5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 01:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVBCGpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 01:45:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65219 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262404AbVBCGps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 01:45:48 -0500
Date: Thu, 3 Feb 2005 06:45:46 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: fix matroxfb ppc compile.
Message-ID: <20050203064546.GD8859@parcelfarce.linux.theplanet.co.uk>
References: <20050203052815.GB10847@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203052815.GB10847@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 12:28:16AM -0500, Dave Jones wrote:
> Code references these vars even though they don't exist.
> Untested other than compile test.

Nope - what it tries to do is to set default_vmode and default_cmode.
See 2.6.11-rc3, it got a fix for that one.
