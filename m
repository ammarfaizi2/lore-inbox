Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSFJQI0>; Mon, 10 Jun 2002 12:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSFJQIZ>; Mon, 10 Jun 2002 12:08:25 -0400
Received: from melchi.fuller.edu ([65.118.138.13]:55826 "EHLO
	melchi.fuller.edu") by vger.kernel.org with ESMTP
	id <S315481AbSFJQIY>; Mon, 10 Jun 2002 12:08:24 -0400
Date: Mon, 10 Jun 2002 09:08:19 -0700 (PDT)
From: <christoph@lameter.com>
X-X-Sender: <christoph@melchi.fuller.edu>
To: <joe.mathewson@btinternet.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <TiM$20020610084203$1595@fusion.mathewson.int>
Message-ID: <Pine.LNX.4.33.0206100906030.29218-100000@melchi.fuller.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002, Joseph Mathewson wrote:

> Does the proposed patch give full symlink support or does it just read
> .lnk files?  Most source tarballs will not have .lnk files in them,
> they will have symlinks.  Would tar create the .lnk files if it was
> extracting to vfat?  If the patch gives symlink support in some other
> way than .lnk files, why can't we just use that and not meddle with
> reading the .lnk files to allow Linux to run in a vfat partition.

Full symlink support. Yes, tar creates symlinks and the vfat fs makes .lnk
files out of the symlinks. when ls displays the directory contents the
vfat fs recognizes the .lnk files and tells the os that there is a
symlink. Its fully transparent. The .lnk files are only visible
under windoze.


