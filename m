Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbTJFQ4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTJFQ4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:56:14 -0400
Received: from bab72-140.optonline.net ([167.206.72.140]:52332 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP id S262377AbTJFQ4J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:56:09 -0400
To: sraphim@mofd.net (Sraphim)
Cc: linux-kernel@vger.kernel.org
Subject: Re: SBP2 does not work with Apple iPod in versions later than 2.4.19
References: <200310061149.28426.sraphim@mofd.net>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 06 Oct 2003 12:56:08 -0400
In-Reply-To: <200310061149.28426.sraphim@mofd.net>
Message-ID: <xltd6dacnkn.fsf@shookay.newview.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sraphim@mofd.net (Sraphim) writes:
> I have recently upgraded from 2.4.19 to 2.4.22, and have discovered that the 
> SBP2 module no longer functions correctly with the Apple iPod (which should 
> behave like a standard firewire disk drive). In the 2.4.19 kernel, it works 
> perfectly, every time, however, it does not anymore. I have also tried every 
> version after 2.4.19, and the same problem exists.
> [...]

Google rescan-scsi-bus.sh

Recent versions of SBP2 don't add the scsi devices automagically meaning
you have to run this tool to manually add them.

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
