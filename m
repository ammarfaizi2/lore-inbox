Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262245AbSIZIUy>; Thu, 26 Sep 2002 04:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262246AbSIZIUy>; Thu, 26 Sep 2002 04:20:54 -0400
Received: from flaxian.hitnet.RWTH-Aachen.DE ([137.226.181.79]:42249 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S262245AbSIZIUx>;
	Thu, 26 Sep 2002 04:20:53 -0400
Date: Thu, 26 Sep 2002 10:26:06 +0200
From: Jan Niehusmann <jan@gondor.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMART *causing* disk lossage?
Message-ID: <20020926082606.GA12918@gondor.com>
References: <Pine.LNX.4.44.0209252246390.26506-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209252246390.26506-100000@twinlark.arctic.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 10:51:37PM -0700, dean gaudet wrote:
> in 4 of the instances, smartd was the first to log anything about a dead
> disk -- it didn't log any change in the smart parameters, just that it
> couldn't reach the drive.  following smartd's complaint were kernel
> messages about resetting the bus, and so forth.

It may be completely unrelated, but we had similar problems in one
server after installing a new gigabit ethernet card. The server ran fine
for several days, and then the disk became unreachable. After a reboot
all was fine for a few days, and then the problem showed up again.

We 'solved' the problem by moving the ethernet card to a different pci
slot where it didn't share it's interrupt with the ide controler.

The mainboard was an asus a7v-133, and the NIC uses the tg3 driver.

Jan

