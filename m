Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263633AbRFFRCa>; Wed, 6 Jun 2001 13:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263634AbRFFRCU>; Wed, 6 Jun 2001 13:02:20 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:7553 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S263633AbRFFRCL>;
	Wed, 6 Jun 2001 13:02:11 -0400
Date: Wed, 6 Jun 2001 19:01:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [driver] New life for Serial mice
Message-ID: <20010606190158.A2010@suse.cz>
In-Reply-To: <20010606125556.A1766@suse.cz> <3B1E5AE0.9202DD00@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B1E5AE0.9202DD00@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Jun 06, 2001 at 12:31:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 12:31:28PM -0400, Jeff Garzik wrote:

> hmmm.  I just looked over this, and drivers/char/joystick/ser*.[ch].
> 
> Bad trend.
> 
> Serial needs to be treated just like parport: the basic hardware code,
> then on top of that, a selection of drivers, all peers:  dumb serial
> port, serial mouse, joystick, etc.

Agreed. Completely.

And proposed a couple times before.

But not in my power.

So I used a N_MOUSE line discipline instead
 - the best tap into the serial/tty stack I found.

-- 
Vojtech Pavlik
SuSE Labs
