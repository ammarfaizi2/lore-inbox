Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbRFBWkU>; Sat, 2 Jun 2001 18:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261968AbRFBWkK>; Sat, 2 Jun 2001 18:40:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61701 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261969AbRFBWjx>;
	Sat, 2 Jun 2001 18:39:53 -0400
Date: Sat, 2 Jun 2001 23:39:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing sysrq
Message-ID: <20010602233920.A23300@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.10.10106011050380.2614-100000@coffee.psychology.mcmaster.ca> <20010601203841Z261493-933+3160@vger.kernel.org> <9f97hu$83v$1@cesium.transmeta.com> <20010602230815.A22390@flint.arm.linux.org.uk> <3B19646F.CBB6DB65@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B19646F.CBB6DB65@transmeta.com>; from hpa@transmeta.com on Sat, Jun 02, 2001 at 03:10:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 02, 2001 at 03:10:55PM -0700, H. Peter Anvin wrote:
> That seems like a very bad idea.  What if there is a boot script bug?

Also think about kernel panics - the only thing that works after that
is the power or (if you have it connected) reset button.  ctrl-alt-del
needs keventd to work, and since sysrq-b is disabled by default...

However, IMHO that is a non-point because you need to be physically
at the system either way to solve the problem.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

