Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbTDWJtl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 05:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTDWJtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 05:49:41 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:64236 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263384AbTDWJtk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 05:49:40 -0400
Date: Wed, 23 Apr 2003 03:05:18 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Nir Livni <nir_l3@netvision.net.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FileSystem Filter Driver
Message-ID: <20030423010518.GA6009@wind.cocodriloo.com>
References: <000501c30983$1ffb8950$ade1db3e@pinguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000501c30983$1ffb8950$ade1db3e@pinguin>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 12:28:33PM +0200, Nir Livni wrote:
> Hi all,
> I am looking for information about writing a FileSystem Filter Driver on RH.
> Any documentation or source code samples whould be appreciated.
> 
> Please make sure you CC' me on any answer for this post, because I am not
> registered (yet ?)
> 
> Thanks,
> Nir

The reference implementation for a filesystem is ext2fs, which
you can have a look at in fs/ext2 on a unpacked kernel tree.
Have also a look at fs/ramfs which is a bit simpler but does
not deal with block devices.

Also have a look at the linux-kernel and linux-fsdevel mailing list
archives.

Greets, Antonio.

