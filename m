Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261953AbREURtT>; Mon, 21 May 2001 13:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261977AbREURtJ>; Mon, 21 May 2001 13:49:09 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:60304 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261953AbREURsw>; Mon, 21 May 2001 13:48:52 -0400
Date: Mon, 21 May 2001 18:41:50 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew McNamara <andrewm@connect.com.au>, tytso@valinux.com,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Ext2, fsync() and MTA's?
Message-ID: <20010521184150.A24682@redhat.com>
In-Reply-To: <20010512115034.A6245285B9@wawura.off.connect.com.au> <E14ya9b-0004Bc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14ya9b-0004Bc-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, May 12, 2001 at 03:13:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 12, 2001 at 03:13:55PM +0100, Alan Cox wrote:

> fsync guarantees the inode data is up to date, fdatasync just the data.

fdatasync guarantees "important" inode data too.  The only thing that
fdatasync is allowed to skip is the timestamps.

--Stephen
