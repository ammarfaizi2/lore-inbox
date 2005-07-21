Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVGUOL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVGUOL5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 10:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVGUOL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 10:11:57 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:33295 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261598AbVGUOL4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 10:11:56 -0400
Message-ID: <42DFAD1C.80004@stud.feec.vutbr.cz>
Date: Thu, 21 Jul 2005 16:11:40 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [RFT] solve "swsusp plays yoyo" with disks
References: <20050705172953.GA18748@elf.ucw.cz>
In-Reply-To: <20050705172953.GA18748@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> I'd like to get this tested under as many configurations as
> possible. With this, your hdd should no longer do "yoyo" (spindown,
> spinup, spindown) during suspend...

It looks like the patch is now in -mm (I use 2.6.13-rc3-mm1).
But my disks still yoyo during suspend. What more is needed? Some patch 
to ide-disk.c ?

Michal
