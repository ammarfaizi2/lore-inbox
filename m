Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSHCAIm>; Fri, 2 Aug 2002 20:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSHCAIm>; Fri, 2 Aug 2002 20:08:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58379 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317457AbSHCAIl>; Fri, 2 Aug 2002 20:08:41 -0400
Date: Sat, 3 Aug 2002 01:12:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: tytso@mit.edu, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
       axel@hh59.org
Subject: Re: Linux 2.5.30: [SERIAL] build fails at 8250.c
Message-ID: <20020803011210.A19722@flint.arm.linux.org.uk>
References: <20020802154924.A5505@baldur.yggdrasil.com> <20020803005626.D16963@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020803005626.D16963@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Aug 03, 2002 at 12:56:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2002 at 12:56:26AM +0100, Russell King wrote:
> 	# Look for usages.
> 	next unless m/LINUX_VERSION_CODE/o;

It should probably look for the other two macros in linux/version.h as
well btw, so it could be generating false negatives.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

