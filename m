Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262204AbSJDVpW>; Fri, 4 Oct 2002 17:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262206AbSJDVpW>; Fri, 4 Oct 2002 17:45:22 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:59577 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S262204AbSJDVpV>;
	Fri, 4 Oct 2002 17:45:21 -0400
Date: Fri, 4 Oct 2002 23:50:49 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Allan Duncan <allan.d@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 etc and IDE HDisk geometry
Message-ID: <20021004215049.GA20192@win.tue.nl>
References: <3D9D9BE4.32421A87@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9D9BE4.32421A87@bigpond.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 11:47:16PM +1000, Allan Duncan wrote:

> Question is - what is determining that initial value that becomes the "logical"
> CHS, and does it matter?

No, it does not matter at all.
CHS are meaningless numbers not used anywhere anymore in Linux.

If you want to influence what geometry *fdisk will use, give it
the appropriate options or commands. No need to go via the kernel.
But only in rare cases is it necessary to worry about geometry.

Andries

> Aside - RedHat has dropped cfdisk from util-linux in their distro versions 7.2 ff.
> Given the bad words said about fdisk, what did cfdisk do to be ostracised?

RedHat thought cfdisk is buggy.
They were mistaken.
