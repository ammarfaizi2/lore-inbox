Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755115AbWKLNa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbWKLNa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbWKLNa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:30:58 -0500
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:26865 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1755114AbWKLNa5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:30:57 -0500
Date: Sun, 12 Nov 2006 13:30:46 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: arm920t s3c24xx
Message-ID: <20061112133046.GB29674@home.fluff.org>
References: <45424CEF.7010808@gandalf.sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45424CEF.7010808@gandalf.sssup.it>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 08:16:15PM +0200, Michael Trimarchi wrote:
> Hi,
> I'm working on an s3c2410 and I notice that in the kernel there is not a
> function to read the bus mode of the arm920t. The kernel may fail to
> report the correct frequencies of the core to the user level. It can
> read the cp15 register to show the core frequency that can be taken from
> the amba bus or the flck.

All the frequencies are reported correctly, as there is no
current reporting of the actual ARM frequency, only the system
clocks, F, H and P.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
