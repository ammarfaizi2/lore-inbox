Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281777AbRKQWZa>; Sat, 17 Nov 2001 17:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281792AbRKQWZY>; Sat, 17 Nov 2001 17:25:24 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:56052
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281777AbRKQWZF>; Sat, 17 Nov 2001 17:25:05 -0500
Date: Sat, 17 Nov 2001 14:24:59 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rock Gordon <rockgordon@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Executing binaries on new filesystem
Message-ID: <20011117142459.J21354@mikef-linux.matchmail.com>
Mail-Followup-To: Rock Gordon <rockgordon@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011117221821.66121.qmail@web14809.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011117221821.66121.qmail@web14809.mail.yahoo.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 02:18:21PM -0800, Rock Gordon wrote:
> Hi,
> 
> I've written a modest filesystem for fun, it works
> pretty ok, but when I try to execute binaries from it,
> bash says "cannot execute binary file" ... If I copy
> the same binary elsewhere, it executes perfectly.
> 

There's probably a way for the FS to tell the rest of the kernel that the
file is executable....  You'll probably need to set that for all files.
That is, unless you have a chmod interface for your "FS for fun"...

Mike
