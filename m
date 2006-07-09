Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbWGIM6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbWGIM6I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 08:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWGIM6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 08:58:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030482AbWGIM6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 08:58:06 -0400
Date: Sun, 9 Jul 2006 14:58:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Automatic Kernel Bug Report
Message-ID: <20060709125805.GF13938@stusta.de>
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com> <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com> <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 06:29:55AM -0400, Daniel Bonekeeper wrote:
>...
> Maybe less verbal. Another problem is that, depending on the
> situation, the problem may be serious enough to not allow a program in
> userspace to work (and therefore, not acknowledge the Oops nor send a
> bug report). Also, important information may not be available for
> userspace (imagine a machine where the kernel wasn't compiled with
> debug stuff, so those details are not exposed to userspace, but
> available at kernelspace). As far as I understood your script, it
> requires interactivity to work (so if we have a bunch of servers in a
> datacenter at 1k miles, we got a problem). My first idea was:
>...

I'm sorry for being so negative, but it seems you are overdesigning a 
solution for a non-existing problem:

There are cases where the machine is simply dead with exactly zero 
information. These are the really hard ones.

Then there are cases where the kernel is able to print a BUG() or Oops 
to a log file. Or the error message is printed to the screen and the 
user uses a digital camera and sends the photo.

The message is usually enough for starting to debug the problem or 
asking the user for additional information.

But most important, the problem lies in a completely different area:

Interaction between kernel devlopers and users is not a real problem.
The real problem is the missing developer manpower for handling bug 
reports.

> Daniel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

