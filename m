Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbSKFJ4p>; Wed, 6 Nov 2002 04:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263249AbSKFJ4p>; Wed, 6 Nov 2002 04:56:45 -0500
Received: from signup.localnet.com ([207.251.201.46]:4811 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S263215AbSKFJ4o>;
	Wed, 6 Nov 2002 04:56:44 -0500
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 dirty ext2 mount error
References: <21293.1036560940@kao2.melbourne.sgi.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <21293.1036560940@kao2.melbourne.sgi.com>
Date: 06 Nov 2002 05:00:51 -0500
Message-ID: <m3y987j9v0.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Keith" == Keith Owens <kaos@ocs.com.au> writes:

Keith> The root partition was originally ext3.  fstab now contains
Keith> /dev/sda1 / ext2 defaults 1 1

Keith> EXT2-fs: sd(8,1): couldn't mount because of unsupported
Keith> optional features (4).  Drop back to 2.4.18 and it works,
Keith> automatically running fsck.ext2 -a /dev/sda1.

Do you perhaps have ext3 compiled into the kernel in your 2.4.18 and
as a module in your 2.4.20-rc1?  That difference would do it, IIRC.

-JimC

