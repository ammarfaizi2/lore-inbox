Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135898AbREIXx3>; Wed, 9 May 2001 19:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135904AbREIXxT>; Wed, 9 May 2001 19:53:19 -0400
Received: from erasmus.off.net ([64.39.30.25]:22023 "HELO erasmus.off.net")
	by vger.kernel.org with SMTP id <S135898AbREIXxF>;
	Wed, 9 May 2001 19:53:05 -0400
Date: Wed, 9 May 2001 19:53:07 -0400
From: Zach Brown <zab@zabbo.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Pavel Roskin <proski@gnu.org>, Pete Zaitcev <zaitcev@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch to make ymfpci legacy address 16 bits
Message-ID: <20010509195307.G30257@erasmus.off.net>
In-Reply-To: <Pine.LNX.4.33.0105091627440.5113-100000@fonzie.nine.com> <3AF9B1BF.A6BCCCE2@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AF9B1BF.A6BCCCE2@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, May 09, 2001 at 05:08:15PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 05:08:15PM -0400, Jeff Garzik wrote:

> Why does maestro.c not use my suggestion?  Because it doesn't use struct
> pci_driver.

I finally found an able hacker with maestro hardware with power
management.  He not only fixed the nasty pm races that were causing
channel corruption, but he seems willing to move it towards the proper
pci_driver APIs as well.

So don't worry Jeff, we'll fix the evil maestro.c driver yet :) :)

- z
