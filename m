Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317424AbSFKSNf>; Tue, 11 Jun 2002 14:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317465AbSFKSNe>; Tue, 11 Jun 2002 14:13:34 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:9745 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317424AbSFKSNe>; Tue, 11 Jun 2002 14:13:34 -0400
Date: Tue, 11 Jun 2002 19:13:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: cfowler <cfowler@outpostsentinel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Break on serial port
Message-ID: <20020611191329.F3665@flint.arm.linux.org.uk>
In-Reply-To: <1023810086.21809.26.camel@moses.outpostsentinel.com> <20020611173520.D3665@flint.arm.linux.org.uk> <1023815676.6689.35.camel@moses.outpostsentinel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 01:14:36PM -0400, cfowler wrote:
> I can not find that ocnfig option anywher in my 2.4.17 tree.  I also
> added CONFIG_MAGIC_SYSRQ=y to the top of .config and then did a  make
> dep and make bzImage.  Upon boot I did not see a /proc/sys/kernel/sysrq

Oops, sorry, you need to enable CONFIG_DEBUG_KERNEL as well.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

