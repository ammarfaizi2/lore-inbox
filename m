Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263766AbRGEU6Y>; Thu, 5 Jul 2001 16:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264825AbRGEU6F>; Thu, 5 Jul 2001 16:58:05 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:64710 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S263766AbRGEU56>; Thu, 5 Jul 2001 16:57:58 -0400
Date: Thu, 5 Jul 2001 21:57:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Stephen C Burns <sburns@farpointer.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LILO calling modprobe?
Message-ID: <20010705215757.J4749@flint.arm.linux.org.uk>
In-Reply-To: <003201c1058c$d9161d30$4201a8c0@lan.farpointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <003201c1058c$d9161d30$4201a8c0@lan.farpointer.net>; from sburns@farpointer.net on Thu, Jul 05, 2001 at 02:58:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 02:58:18PM -0500, Stephen C Burns wrote:
> modprobe: Can't locate module block-major-3

If you want to get rid of this, add:

alias block-major-3 off

in /etc/modules.conf

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

