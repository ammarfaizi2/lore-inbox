Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUDXI4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUDXI4n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 04:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUDXI4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 04:56:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44559 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262085AbUDXI4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 04:56:42 -0400
Date: Sat, 24 Apr 2004 09:56:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org,
       Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Subject: Re: [2.6 patch] Canonically reference files in Documentation/ code comments part
Message-ID: <20040424095628.B25661@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org,
	Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
References: <20040423231057.GF24948@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040423231057.GF24948@fs.tum.de>; from bunk@fs.tum.de on Sat, Apr 24, 2004 at 01:10:58AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2004 at 01:10:58AM +0200, Adrian Bunk wrote:
> Below is an updated version of a patch by 
> Hans Ulrich Niedermann <linux-kernel@n-dimensional.de> to 
> change all references in comments to files in Documentation/ to start 
> with Documentation/ .

I'd prefer to include the 'linux/' part so its obvious that we're
referring to the kernel tree.  I've given people pointers to files
in the past, and just giving "Documentation/foo/bar" usually results
in "I've looked on the web here, there and somewhere else and can't
find the file."

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
