Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289341AbSBJHuf>; Sun, 10 Feb 2002 02:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289342AbSBJHuZ>; Sun, 10 Feb 2002 02:50:25 -0500
Received: from ns.suse.de ([213.95.15.193]:36364 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289341AbSBJHuO>;
	Sun, 10 Feb 2002 02:50:14 -0500
To: Pawel Worach <pawel.worach@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-pre9
In-Reply-To: <3C662264.9090207@telia.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Feb 2002 08:50:11 +0100
In-Reply-To: Pawel Worach's message of "10 Feb 2002 08:35:27 +0100"
Message-ID: <p738za122to.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Worach <pawel.worach@telia.com> writes:

> .... abit bp6 with two intel celeron cpu's....

...

> 
> VM: killing process sendmail
> swap_free: Unused swap offset entry 00004000
                                      ^^^^^^^^^
Very much looks like a single bit memory corruption. And an unsupported 
SMP configuration with a known-to-be-problematic board too. 
I would suspect hardware.


-Andi
