Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131670AbRCSXoU>; Mon, 19 Mar 2001 18:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131671AbRCSXoL>; Mon, 19 Mar 2001 18:44:11 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:58916 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S131670AbRCSXoB>;
	Mon, 19 Mar 2001 18:44:01 -0500
Message-ID: <20010320004317.A1414@win.tue.nl>
Date: Tue, 20 Mar 2001 00:43:17 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'Jeremy Jackson'" <jerj@coplanar.net>, root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: on /etc/mtab vs. /proc/mounts
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B42@mail0.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B42@mail0.myrio.com>; from Torrey Hoffman on Mon, Mar 19, 2001 at 03:05:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2001 at 03:05:55PM -0800, Torrey Hoffman wrote:

> In fact, the "mount" man page on my Mandrake 7.2 system says:
> 
> "It is possible to replace /etc/mtab by a symbolic link to 
> /proc/mounts..."  and then goes on to describe some of the issues and
> problems with doing so - loopback, and paths with spaces seem to
> be the significant ones.

The spaces part was fixed in patch-2.4.0-test7.

Today there is a different flaw again:
After "mount --bind somedir mountpoint" there is no
indication of somedir in /proc/mounts.

Andries
