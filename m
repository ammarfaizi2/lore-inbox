Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261468AbTC0Ww4>; Thu, 27 Mar 2003 17:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261470AbTC0Ww4>; Thu, 27 Mar 2003 17:52:56 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:17383 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261468AbTC0Ww4>; Thu, 27 Mar 2003 17:52:56 -0500
Date: Thu, 27 Mar 2003 23:03:50 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: dan carpenter <d_carpenter@sbcglobal.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 509] New: NULL pointer when rmmod faulty driver
Message-ID: <20030327230343.GA16251@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	dan carpenter <d_carpenter@sbcglobal.net>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1451130000.1048708440@flay> <200303270446.h2R4kGu4636448@pimout1-ext.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303270446.h2R4kGu4636448@pimout1-ext.prodigy.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 12:25:28PM +0100, dan carpenter wrote:

 > > Mar 26 20:27:14 localhost kernel: drivers/usb/host/uhci-hcd.c: 1000: host
 > > controller halted. very bad
 > 
 > There is a fixme next to the printf statement in 
 > drivers/usb/host/uhci-hcd.c

I saw the same message until recently.
I believe this was fixed in 2.5.65, see http://bugzilla.kernel.org/show_bug.cgi?id=403

 > The quickcam source isn't available to fix the null dereference bug.

Indeed.

		Dave
