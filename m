Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbTCHQCj>; Sat, 8 Mar 2003 11:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262064AbTCHQCj>; Sat, 8 Mar 2003 11:02:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12049 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262062AbTCHQCg>; Sat, 8 Mar 2003 11:02:36 -0500
Date: Sat, 8 Mar 2003 16:13:09 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
Message-ID: <20030308161309.B1896@flint.arm.linux.org.uk>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv> <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com> <20030307233916.Q17492@flint.arm.linux.org.uk> <m1d6l2lih9.fsf@frodo.biederman.org> <20030308100359.A27153@flint.arm.linux.org.uk> <m18yvpluw7.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m18yvpluw7.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Mar 08, 2003 at 08:50:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 08:50:48AM -0700, Eric W. Biederman wrote:
> Exactly.  And you build it for the specific purpose of just
> configuring the system.  And by not handling the general case you
> should be able to get another significant size reduction.

You do not want to be too specific though - a kernel with features
X, Y, and Z in the current setup can boot using any of those features
by just supplying the appropriate command line.

The reason HPA wanted to go down the userspace route, btw, was to
support additional add-ons for bringing other stuff up - remember this
is part of the initramfs spec that was reviewed by this list many
months ago?  Or has that now gone completely out of the window?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

