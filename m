Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267714AbTBGEzs>; Thu, 6 Feb 2003 23:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267717AbTBGEzs>; Thu, 6 Feb 2003 23:55:48 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:21779 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267714AbTBGEzr>;
	Thu, 6 Feb 2003 23:55:47 -0500
Date: Thu, 6 Feb 2003 21:00:47 -0800
From: Greg KH <greg@kroah.com>
To: arnd@bergmann-dalldorf.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: klibc update
Message-ID: <20030207050047.GB30526@kroah.com>
References: <200302061307.33944.arndb@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302061307.33944.arndb@de.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 01:07:33PM +0100, Arnd Bergmann wrote:
> I found what kept initramfs from working here: While creating
> of initramfs_data.cpio.gz, the padding between a file header
> and the file contents was wrong, which can be verified by
> unpacking the archive by hand.
> 
> The trivial patch below fixed this for me.

Thanks a lot for the patch, I've added it to my tree, and verified that
the uncompressed archive works properly.

thanks again,

greg k-h
