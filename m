Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbTB0Ipv>; Thu, 27 Feb 2003 03:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbTB0Ipv>; Thu, 27 Feb 2003 03:45:51 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:55813 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S262418AbTB0Ipv>; Thu, 27 Feb 2003 03:45:51 -0500
Date: Thu, 27 Feb 2003 08:55:39 +0000
To: Greg KH <greg@kroah.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] dm: __LOW macro fix no. 2
Message-ID: <20030227085538.GA1495@fib011235813.fsnet.co.uk>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk> <20030226171249.GG8369@fib011235813.fsnet.co.uk> <20030226181454.GA16350@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226181454.GA16350@kroah.com>
User-Agent: Mutt/1.5.3i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 10:14:54AM -0800, Greg KH wrote:
> By special casing the logic in your __LOW() macro, you're only asking
> for trouble in the long run :)

I think you're right, the __HIGH and __LOW macros are just obfuscating
things.  I'll fix in the next patchset.

Thanks,

- Joe
