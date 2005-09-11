Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVIKAsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVIKAsb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbVIKAsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:48:30 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:37284 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S964775AbVIKAs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:48:29 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Sat, 10 Sep 2005 17:48:05 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
In-Reply-To: <20050909214542.GA29200@kroah.com>
Message-ID: <Pine.LNX.4.62.0509101742300.28852@qynat.qvtvafvgr.pbz>
References: <20050909214542.GA29200@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Greg KH wrote:

> Date: Fri, 9 Sep 2005 14:45:42 -0700
> From: Greg KH <gregkh@suse.de>
> To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: [GIT PATCH] Remove devfs from 2.6.13
> 
> Here are the same "delete devfs" patches that I submitted for 2.6.12.
> It rips out all of devfs from the kernel and ends up saving a lot of
> space.  Since 2.6.13 came out, I have seen no complaints about the fact
> that devfs was not able to be enabled anymore, and in fact, a lot of
> different subsystems have already been deleting devfs support for a
> while now, with apparently no complaints (due to the lack of users.)

do you really think that there have been that many people who have shifted 
to 2.6.13 in less then 2 weeks since release?

I know that you take personal offense to this code existing, but Andrew 
pointed out when you proposed these patches before that we need to be 
acareful here

David Lang
