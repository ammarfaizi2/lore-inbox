Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317633AbSFRVuH>; Tue, 18 Jun 2002 17:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317634AbSFRVuG>; Tue, 18 Jun 2002 17:50:06 -0400
Received: from pc-62-31-66-56-ed.blueyonder.co.uk ([62.31.66.56]:34180 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S317633AbSFRVuF>; Tue, 18 Jun 2002 17:50:05 -0400
Date: Tue, 18 Jun 2002 22:50:05 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Stephen Tweedie <sct@redhat.com>
Subject: Re: Shrinking ext3 directories
Message-ID: <20020618225005.A7897@redhat.com>
References: <3D0F5AFC.mailGSE111D9L@viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D0F5AFC.mailGSE111D9L@viadomus.com>; from raul@pleyades.net on Tue, Jun 18, 2002 at 06:08:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 18, 2002 at 06:08:28PM +0200, DervishD wrote:
 
>     All of you know that if you create a lot of files or directories
> within a directory on ext2/3 and after that you remove them, the
> blocks aren't freed (this is the reason behind the lost+found block
> preallocation). If you want to 'shrink' the directory now that it
> doesn't contain a lot of leafs, the only solution I know is creating
> a new directory, move the remaining leafs to it, remove the
> 'big-unshrinken' directory and after that renaming the new directory

Right.  Shrinking directories is not implemented for ext2 or ext3 at
the moment.  However, I know that Daniel Phillips has been thinking
about adding that for his HTree extensions which add fast directory
indexing to ext2/3.

Cheers,
 Stephen
