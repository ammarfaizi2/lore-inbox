Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266083AbRF1SZf>; Thu, 28 Jun 2001 14:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266085AbRF1SZZ>; Thu, 28 Jun 2001 14:25:25 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:10756 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S266083AbRF1SZT>;
	Thu, 28 Jun 2001 14:25:19 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106281825.f5SIPIA386711@saturn.cs.uml.edu>
Subject: Re: [PATCH] User chroot
To: sean@dev.sportingbet.com (Sean Hunter)
Date: Thu, 28 Jun 2001 14:25:18 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010628084703.B27891@dev.sportingbet.com> from "Sean Hunter" at Jun 28, 2001 08:47:03 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hunter writes:
> On Wed, Jun 27, 2001 at 04:55:56PM -0400, Albert D. Cahalan wrote:

>> ln /dev/zero /tmp/zero
>> ln /dev/hda ~/hda
>> ln /dev/mem /var/tmp/README
>
> None of these (of course) work if you use mount options to
> restrict device nodes on those filesystems.

In which case, you can't boot. Think about it.

Never mind the method. One way or another, it is very often
possible for a normal users to set up a chroot environment
with the device files that are needed. Maybe they do something
obscene with the admin. :-) So chroot() is useful for users.

In my case, I _am_ the admin and I just don't want to run
every damn little test program and hack as root.

