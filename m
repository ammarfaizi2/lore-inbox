Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbSLMSVo>; Fri, 13 Dec 2002 13:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbSLMSVo>; Fri, 13 Dec 2002 13:21:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57355 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265238AbSLMSVn>; Fri, 13 Dec 2002 13:21:43 -0500
Date: Fri, 13 Dec 2002 18:29:30 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH 2.4.21-BK] Fix typo in arch/arm/config.in
Message-ID: <20021213182930.E6567@flint.arm.linux.org.uk>
Mail-Followup-To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <200212131844.45280.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212131844.45280.m.c.p@wolk-project.de>; from m.c.p@wolk-project.de on Fri, Dec 13, 2002 at 06:47:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 06:47:08PM +0100, Marc-Christian Petersen wrote:
> this fixes a typo in arch/arm/config.in.
> 
> old:    source drivers/ssi/Config.in
> new:	source drivers/scsi/Config.in
> 
>  Without it, make menuconfig crashes.

Only that?  I'm surprised - there's a hell of a lot of outstanding
stuff for 2.4 for ARM.

Bluntly, I'm not interested in reports and fixes against Marcelo's
tree for ARM stuff because its fairly out of date, and a fair amount
of required generic changes didn't make it into what was Linus' tree
before Marcelo took it over.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

