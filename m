Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130156AbRCGT6n>; Wed, 7 Mar 2001 14:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRCGT6d>; Wed, 7 Mar 2001 14:58:33 -0500
Received: from m499-mp1-cvx1a.col.ntl.com ([213.104.69.243]:35076 "EHLO
	[213.104.69.243]") by vger.kernel.org with ESMTP id <S129734AbRCGT6S>;
	Wed, 7 Mar 2001 14:58:18 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: Forcible removal of modules
In-Reply-To: <9038100.983917051702.JavaMail.imail@digger.excite.com>
From: John Fremlin <chief@bandits.org>
Date: 07 Mar 2001 19:57:22 +0000
In-Reply-To: Thomas Hood's message of "Tue, 6 Mar 2001 14:17:28 -0800 (PST)"
Message-ID: <m2vgpltkrh.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Thomas Hood <thood@excite.com> writes:

> Sometimes modules need to be reloaded in order
> to cause some sort of reinitialization (of the
> driver or of the hardware) to occur.

Why not set up the device driver to handle PM events itself. See
Documentation/pm.txt under Driver Interface.

I have a race free version of pm_send_all if you want it.

[...]

-- 

	http://www.penguinpowered.com/~vii
