Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSLOTa3>; Sun, 15 Dec 2002 14:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSLOTa3>; Sun, 15 Dec 2002 14:30:29 -0500
Received: from dutidad.twi.tudelft.nl ([130.161.157.74]:51662 "EHLO
	dutidad.twi.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262392AbSLOTa2>; Sun, 15 Dec 2002 14:30:28 -0500
Date: Sun, 15 Dec 2002 20:37:47 +0100
From: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
To: gthomsen@sbcglobal.net
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] PROBLEM: 2.4.{19,20} fails to resume if radeon.o is loaded
Message-ID: <20021215193747.GA10834@dutidad.twi.tudelft.nl>
References: <E18NO8U-0005j1-00@doma.ballum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18NO8U-0005j1-00@doma.ballum>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2002 at 06:04:06PM -0800, tho@doma.ballum.wikaba.com wrote:
> after about a dozen reboots and half a dozen fscks, I finally was
> able to pinpoint the reason of why my laptop (ThinkPad X22 (2662XXK))
> wasn't able to resume after suspend.
> 
> The DRM module 'radeon.o' somehow prevents a successful resume (but
> not the suspend). Only after I made that module unavailable to the
> modutils, my laptop now successfully completes suspend/resume cycles.

http://www.google.com/search?q=dri+radeon+resume
Yields:
http://cpbotha.net/dri_resume.html

This is applicable only if you're interested in suspending/resuming with
active DRI, which it doesn't seem you are.  So it's just FYI :)

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/
