Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWDTKJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWDTKJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWDTKJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:09:07 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:63902 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S1750819AbWDTKJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:09:05 -0400
Message-ID: <44475D93.60506@blackdown.de>
Date: Thu, 20 Apr 2006 12:08:19 +0200
From: Juergen Kreileder <jk@blackdown.de>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: akpm@osdl.org, torvalds@osdl.org, agk@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Device-mapper snapshot metadata userspace breakage
References: <Pine.LNX.4.58.0604201159350.29821@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0604201159350.29821@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
 > The commit aa14edeb994f8f7e223d02ad14780bf2fa719f6d "[PATCH] device-mapper
 > snapshot: load metadata on creation" breaks userspace and is blocking us
 > from moving to the 2.6.16 series kernel. Debian doesn't have the
 > new required LVM version in stable yet. Is the change intentional?

I've made backports of newer tools for sarge[1].  But even with that
snapshots can't be removed reliable with 2.6.16, I get
'BUG at drivers/md/kcopyd.c:146'. (More info in
http://www.ussg.iu.edu/hypermail/linux/kernel/0604.1/1643.html)


	Juergen

[1] http://blog.blackdown.de/2006/04/09/lvm-snapshots-with-debian-sarge-and-linux-2616/

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
