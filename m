Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbRF0BSN>; Tue, 26 Jun 2001 21:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265202AbRF0BRx>; Tue, 26 Jun 2001 21:17:53 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:10249 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S265205AbRF0BRr>; Tue, 26 Jun 2001 21:17:47 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot 
cc: pmenage@ensim.com
In-Reply-To: Your message of "Tue, 26 Jun 2001 21:08:50 EDT."
             <3B393222.14273547@haque.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jun 2001 18:24:07 -0700
Message-Id: <E15F43r-0003ls-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Paul Menage wrote:
>> This could be regarded as the wrong way to solve such a problem, but
>> this kind of bug seems to be occurring often enough on BugTraq that it
>> might be useful if you don't have the resources to do a full security
>> audit on your program (or if the source to some of your libraries
>> isn't available).
>
>Why do this in the kernel when it's available in userspace?
>
>http://freshmeat.net/projects/rj/
>

But only root can set this up, since you currently have to be root in
order to chroot(). The (only) advantage of the user chroot() patch would
be that users would be able to do the same thing without root
intervention.

Paul

