Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290131AbSAKV4p>; Fri, 11 Jan 2002 16:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290132AbSAKV4a>; Fri, 11 Jan 2002 16:56:30 -0500
Received: from ms25.windstoneinc.com ([206.222.212.217]:23276 "EHLO
	unpythonic.dhs.org") by vger.kernel.org with ESMTP
	id <S290131AbSAKV4N>; Fri, 11 Jan 2002 16:56:13 -0500
Date: Fri, 11 Jan 2002 15:55:57 -0600
From: jepler@unpythonic.dhs.org
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LOSETUP COMMAND
Message-ID: <20020111155557.B5764@unpythonic.dhs.org>
In-Reply-To: <20020111210333.46759.qmail@web14912.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020111210333.46759.qmail@web14912.mail.yahoo.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 04:03:33PM -0500, Michael Zhu wrote:
> Hello, everyone, does anyone know where I can find the
> source code of "losetup" and "mount"?  Thanks

If you're using an RPM-based distribution, you can use rpm to find this
kind of information.

$ rpm -qf /bin/mount
mount-2.10f-1

Now, get the mount-2.10f-1.src.rpm from your install media, use rpm -ivh to
install it, then rpm -bp on the installed specfile to recover the actual
source tree used to build that version of mount.

Jeff
