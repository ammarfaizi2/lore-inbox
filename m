Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261602AbTCGOUo>; Fri, 7 Mar 2003 09:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbTCGOUo>; Fri, 7 Mar 2003 09:20:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33808 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261597AbTCGOUn>; Fri, 7 Mar 2003 09:20:43 -0500
Date: Fri, 7 Mar 2003 14:31:14 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: SANTHOSH K <santhoshk@nestec.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: cardbus driver
Message-ID: <20030307143114.G17492@flint.arm.linux.org.uk>
Mail-Followup-To: SANTHOSH K <santhoshk@nestec.net>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <F6E1228667B6D411BAAA00306E00F2A5153AB2@pdc2.nestec.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F6E1228667B6D411BAAA00306E00F2A5153AB2@pdc2.nestec.net>; from santhoshk@nestec.net on Fri, Mar 07, 2003 at 07:08:29PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 07:08:29PM +0530, SANTHOSH K wrote:
> What change need to be done to give support for a pccard driver to a cardbus
> driver?

Electrically, they're different interfaces.  If the controller hardware
you're using doesn't support cardbus cards, no amount of software will
make them work.

Could you give some details about the hardware and the driver?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

