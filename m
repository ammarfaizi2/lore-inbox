Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264200AbRFMTnX>; Wed, 13 Jun 2001 15:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264204AbRFMTnN>; Wed, 13 Jun 2001 15:43:13 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:13575
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S264200AbRFMTnG>;
	Wed, 13 Jun 2001 15:43:06 -0400
To: Russ Lewis <russl@lycosmail.com>
Subject: Re: Has it been done: User Script File System?
Message-ID: <992461384.3b27c248c8b0f@www.goop.org>
Date: Wed, 13 Jun 2001 12:43:04 -0700 (PDT)
From: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B27A546.A64F8B00@lycosmail.com>
In-Reply-To: <3B27A546.A64F8B00@lycosmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Russ Lewis <russl@lycosmail.com>:
> mount -t userfs   /etc/myfs.conf   /myfs

I did this a while ago: I wrote userfs which allowed arbirary filesystems to be
implemented in user space.  One of these was a filesystem which allowed you to
embed scripts in symlinks, such that stdout of the script was read as the
contents of the file.

userfs has fallen into disrepair lately, but there are other projects with
similar goals.  See http://www.goop.org/~jeremy/userfs/.

    J
