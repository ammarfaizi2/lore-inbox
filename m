Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbTEHKIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 06:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbTEHKIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 06:08:14 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:33446 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261253AbTEHKIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 06:08:12 -0400
Date: Thu, 8 May 2003 12:20:46 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binary firmware in the kernel - licensing issues.
Message-ID: <20030508102046.GJ1469@wohnheim.fh-wedel.de>
References: <3EB79ECE.4010709@thekelleys.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EB79ECE.4010709@thekelleys.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003 12:38:54 +0100, Simon Kelley wrote:
> 
> BUT. These things need firmware loaded, at least the ones without
> built-in flash. The Atmel drivers come with binary firmware
> as header files full of hex, with the following notice.
> 
> It isn't clear what the license agreement referred to in the above
> actually is, but I don't think it's reasonable to just assume it's the
> GPL and shove these files into the kernel as-is.

After some thoughts, this appears to be related to NDA processor
documentation not included in the kernel source.

For the kernel or the main CPU, the driver firmware is just data. The
same, as the magic 0x12345678ul that gets written to some register
because [can't tell, NDA]. In both cases, magic data gets written
somewhere and afterwards, things just work.

So binary code that doesn't get executed on the main CPU *should* be
ok, but whether the lawyers would agree, I have no idea.

Jörn

-- 
"Translations are and will always be problematic. They inflict violence 
upon two languages." (translation from German)
