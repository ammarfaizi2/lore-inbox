Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbTFNI23 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 04:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbTFNI23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 04:28:29 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:49415 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S265649AbTFNI2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 04:28:24 -0400
Date: Sat, 14 Jun 2003 03:42:12 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Microstar MS-6163 blacklist [IO-APIC]
Message-ID: <20030614084212.GJ867@dbz.icequake.net>
References: <20030614014646.GD1010@dbz.icequake.net> <1055578753.7651.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1055578753.7651.3.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 09:19:14AM +0100, Alan Cox wrote:
> On Sad, 2003-06-14 at 02:46, Ryan Underwood wrote:
> > It would seem that if a closer match were performed, using the version
> > number of the board (3.X in my case, likely 2.X in the case of the
> > broken Pro), it would be a better idea.  Perhaps another alternative
> > solution would be to only disable the IO-APIC if CONFIG_APM is defined.
> > (?)
> 
> Its more likely to be about BIOS version than about the board itself

It would have been nice if the original submitter of the patch would
have specified what bios they were using.  IO-APIC support on my board
seemed to be working nicely until eventually it got disabled. :)

I am using the 5.6 bios from their site for the BX Master -- the 6163
Pro (v2) has a totally different BIOS versions and I'm not sure if a
blanket black-list for this board would be the best idea.

Thanks,
-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253
