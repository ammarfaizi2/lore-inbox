Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316671AbSEVSi4>; Wed, 22 May 2002 14:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSEVShh>; Wed, 22 May 2002 14:37:37 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:31493 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316668AbSEVSgK>; Wed, 22 May 2002 14:36:10 -0400
Date: Wed, 22 May 2002 19:36:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
Message-ID: <20020522193601.L16934@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0205220901430.7580-100000@home.transmeta.com> <3CEBB385.5040904@evision-ventures.com> <20020522165834.GD12982@atrey.karlin.mff.cuni.cz> <3CEBC29B.2050601@evision-ventures.com> <20020522175636.GB24755@atrey.karlin.mff.cuni.cz> <3CEBCDCA.8030905@evision-ventures.com> <20020522181753.GE24755@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 08:17:53PM +0200, Jan Kara wrote:
>   OK. You convinced me that 'version' isn't needed. But how about
> 'formats'? Currently quotaon(8) uses this field to check which format it
> should try to turn on... I can live without it as quotaon(8) might try
> new format and if it doesn't succeed it will try the old one but
> anyway...

Each sysctl file is only supposed to carry one bit of information - one
number, one string.  There should be no formatting of data.

Have a look at /proc/sys/net/ipv4/* as an example.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

