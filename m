Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSGCJxY>; Wed, 3 Jul 2002 05:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSGCJxX>; Wed, 3 Jul 2002 05:53:23 -0400
Received: from angband.namesys.com ([212.16.7.85]:23936 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S315437AbSGCJxV>; Wed, 3 Jul 2002 05:53:21 -0400
Date: Wed, 3 Jul 2002 13:55:45 +0400
From: Oleg Drokin <green@namesys.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Paul Menage <pmenage@ensim.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shift BKL into ->statfs()
Message-ID: <20020703135545.A1154@namesys.com>
References: <E17PYtv-0004Fd-00@pmenage-dt.ensim.com> <Pine.GSO.4.21.0207030208080.6472-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0207030208080.6472-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jul 03, 2002 at 02:25:02AM -0400, Alexander Viro wrote:

> 	2) ext2, shmem, FAT, minix and sysv ->statfs() don't need BKL.

reiserfs does not need BKL in ->statfs() too.

Bye,
    Oleg
