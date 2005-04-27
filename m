Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVD0JKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVD0JKG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 05:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVD0JKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 05:10:06 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:45319 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261288AbVD0JKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 05:10:00 -0400
Message-ID: <426F57FB.4020404@aitel.hist.no>
Date: Wed, 27 Apr 2005 11:14:35 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <20050424214339.GD9304@mail.shareable.org>
In-Reply-To: <20050424214339.GD9304@mail.shareable.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

> He wants to do this:
>
>   1. From client, login to server and do a usermount on $HOME/private.
>
>   2. From client, login to server and read the files previously mounted.
>  
>
This is works fine with plain "mount", except that the mount isn't
hidden from others.  Why hide it?  Permissions can be used to prevent
others from looking at the mounted stuff if need be.  I.e. put
the mountpoint in a directory not readable by others, or
have the root of that fs unreadable by others.

Helge Hafting
