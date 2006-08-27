Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWH0HLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWH0HLd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 03:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWH0HLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 03:11:33 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:62542 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751316AbWH0HLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 03:11:32 -0400
Date: Sun, 27 Aug 2006 09:11:31 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Peter <sw98234@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wrt: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Message-ID: <20060827071131.GC6932@bitwizard.nl>
References: <ecpru4$9t3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecpru4$9t3$1@sea.gmane.org>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 04:12:52PM +0000, Peter wrote:
> Diagnostics on the drives are fine. Removing the b drive removes the
> messages. System functions fine anyway, and no data is lost as a result
> of the errors. The persistence of it is frustrating!

What diagnostics did you try? 

(I've got experience with a guy saying: "I have 5 which test perfect
with my diagnostics, but my embedded machine refuses them. What's
wrong?" All of them report through SMART that they HAVE reported media
errors, and they all have bad blocks.)

Do you have "smartd" running? I vaguely remember that it sometimes
triggered error messages from the normal driver. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
