Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279003AbRJaBqb>; Tue, 30 Oct 2001 20:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279105AbRJaBqU>; Tue, 30 Oct 2001 20:46:20 -0500
Received: from ns.suse.de ([213.95.15.193]:37905 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279003AbRJaBqP>;
	Tue, 30 Oct 2001 20:46:15 -0500
Date: Wed, 31 Oct 2001 02:46:51 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Mark Atwood <mra@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Identify IDE device?
In-Reply-To: <m3pu74k4v5.fsf@khem.blackfedora.com>
Message-ID: <Pine.LNX.4.30.0110310244150.30529-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Oct 2001, Mark Atwood wrote:

> Is there a way, via an ioctl call, or something to identify what
> specific IDE hard disk or other IDE device is hooked up to the IDE
> controller?

HDIO_GET_IDENTITY is the ioctl you seek.

Grab the hdparm source for an example of how to use this and other
IDE related ioctls.

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

