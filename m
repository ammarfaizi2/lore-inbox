Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVBTK6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVBTK6G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 05:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVBTK6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 05:58:06 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:36241 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S261814AbVBTK54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 05:57:56 -0500
Date: Sun, 20 Feb 2005 11:57:54 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad G41 PCMCIA problems
Message-ID: <20050220105753.GA13915@hardeman.nu>
References: <20050220092208.GA12738@hardeman.nu> <20050220092659.A9509@flint.arm.linux.org.uk> <20050220095211.GB12738@hardeman.nu> <20050220101902.B9509@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050220101902.B9509@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 10:19:02AM +0000, Russell King wrote:
>On Sun, Feb 20, 2005 at 10:52:12AM +0100, David Härdeman wrote:
>> Is the hole between 0x36f6fa000 and 0x3f700000?
>
>Looks like it.
>
>> And what would be the proper way of fixing it (assuming that IBM won't 
>> issue a fixed BIOS)?
>
>Try passing:
>
>	reserve=0x3f6fa000,0x6000
>
>to the kernel.
>

Thanks a bunch, that worked, now I don't have to patch my kernel 
to get PCMCIA working anymore :-)

//David
