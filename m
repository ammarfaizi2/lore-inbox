Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280728AbRKJWEJ>; Sat, 10 Nov 2001 17:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280729AbRKJWD7>; Sat, 10 Nov 2001 17:03:59 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:20212
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280728AbRKJWDk>; Sat, 10 Nov 2001 17:03:40 -0500
Date: Sat, 10 Nov 2001 14:03:31 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Thomas Foerster <puckwork@madz.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Module / Patch with implements "sshfs"
Message-ID: <20011110140331.C446@mikef-linux.matchmail.com>
Mail-Followup-To: Thomas Foerster <puckwork@madz.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011109152819Z279925-17408+12662@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011109152819Z279925-17408+12662@vger.kernel.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 04:26:07PM +0100, Thomas Foerster wrote:
> Hi folks,
> 
> i came across the idea to mount a remote filesystem via SSH[1|2].
> 
> I've seen a free program for Windows that implements parts of what i'm
> thinking of.
> 
> Does someone know about a kernel module/patch to implement a "sshfs" ?
> (to be used with mount)
> 
> What i want to do is to mount my webserver (external ip) from an internal
> system (internal ip).
> 

Check out freeswan (www.freeswan.org).  It adds IPsec support to the linux
kernel.

Once you have a tunnel setup with IPsec, you can use nfs, or whatever other
network file system over the internet safely...

Mike
