Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262401AbREUIPX>; Mon, 21 May 2001 04:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262400AbREUIPN>; Mon, 21 May 2001 04:15:13 -0400
Received: from gate.in-addr.de ([212.8.193.158]:23812 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S262358AbREUIPF>;
	Mon, 21 May 2001 04:15:05 -0400
Date: Mon, 21 May 2001 10:14:51 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Ben LaHaise <bcrl@redhat.com>,
        torvalds@transmeta.com, viro@math.psu.edu,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re:  [RFD w/info-PATCH] device arguments from lookup, partion code in userspace
Message-ID: <20010521101451.F555@marowsky-bree.de>
In-Reply-To: <Pine.LNX.4.33.0105190138150.6079-100000@toomuch.toronto.redhat.com> <m14ruhin7d.fsf@frodo.biederman.org> <01051916254708.00491@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <01051916254708.00491@starship>; from "Daniel Phillips" on 2001-05-19T16:25:47
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-05-19T16:25:47,
   Daniel Phillips <phillips@bonn-fries.net> said:

> How about:
> 
>   # mkpart /dev/sda /dev/mypartition -o size=1024k,type=swap
>   # ls /dev/mypartition
>   base	size	device	type
>   # cat /dev/mypartition/size
>   1048576
>   # cat /dev/mypartition/device
>   /dev/sda
>   # mke2fs /dev/mypartition

Ek. You want to run mke2fs on a _directory_ ?

If anything, /dev/mypartition/realdev

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

