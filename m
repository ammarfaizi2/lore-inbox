Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbSBMNrj>; Wed, 13 Feb 2002 08:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbSBMNr3>; Wed, 13 Feb 2002 08:47:29 -0500
Received: from dsl-65-185-241-169.telocity.com ([65.185.241.169]:10112 "EHLO
	mail.temp123.org") by vger.kernel.org with ESMTP id <S282843AbSBMNrU>;
	Wed, 13 Feb 2002 08:47:20 -0500
Date: Wed, 13 Feb 2002 08:47:25 -0500
From: Faux Pas III <fauxpas@temp123.org>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 Oops, maybe LVM ?
Message-ID: <20020213134725.GA755@temp123.org>
In-Reply-To: <20020213063548.GA463@temp123.org> <20020213090748.GA2421@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020213090748.GA2421@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 09:07:48AM +0000, Joe Thornber wrote:

> Do you have any other reason to suspect LVM ?  eg, have you tried
> it successfully on a non-LVM device ?

It seems to only crash reliably when I pull a file off the filesystem
that's on the lv, but I haven't been at all scientific in determining
that.  =)  I'll try to kill it without LVM being in the picture.

> have you tried it without the acls patch ?

Yes.  Still crashes under the same conditions with the 'eth0: Abnormal
interrupt' bit, but the oops might be very different.  I'll try to get 
an oops with a vanilla kernel...

-- 
Josh Litherland (fauxpas@temp123.org)
