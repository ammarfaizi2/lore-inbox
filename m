Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262925AbSJGIez>; Mon, 7 Oct 2002 04:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262926AbSJGIez>; Mon, 7 Oct 2002 04:34:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59652 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262925AbSJGIey>; Mon, 7 Oct 2002 04:34:54 -0400
Date: Mon, 7 Oct 2002 09:40:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: DevilKin <devilkin-lkml@blindguardian.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.50 - 8250_cs does NOT work
Message-ID: <20021007094026.B803@flint.arm.linux.org.uk>
References: <20021002120540.D24770@flint.arm.linux.org.uk> <200210021257.43121.devilkin-lkml@blindguardian.org> <20021002120540.D24770@flint.arm.linux.org.uk> <18990.1033979667@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <18990.1033979667@passion.cambridge.redhat.com>; from dwmw2@infradead.org on Mon, Oct 07, 2002 at 09:34:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 09:34:27AM +0100, David Woodhouse wrote:
> Doesn't compile. ALPHA_KLUDGE_MCR undefined. That crap in the generic 8250
> code should go away in favour of some mask bits set by the platform-specific
> code when it registers the ports. You probably want to set the default _and_
> the permitted bits that way.

Oddly, thats what DevilKin reported.  This isn't the patch I sent Linus.
8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

