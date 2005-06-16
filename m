Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVFPS5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVFPS5p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 14:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVFPS5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 14:57:45 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:28612 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261789AbVFPS5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 14:57:41 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <42B1CA6E.1080402@namesys.com>
Date: Thu, 16 Jun 2005 11:52:30 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: fs <fs@ercist.iscas.ac.cn>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       viro VFS <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, sct@redhat.com, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [RFD] FS behavior (I/O failure) in kernel summit
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <42ADFFD5.1090905@suse.com> <42AE1EE4.5090508@namesys.com> <42B067B6.9030009@suse.com>
In-Reply-To: <42B067B6.9030009@suse.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:

>
> As far as the ReiserFS support goes, I was premature in stating that
> ReiserFS supports behavior 1b. It does so in terms of journal errors,
> but it does just warn and continue on other errors. I'm working on a
> patch that introduces reiserfs_error() similar to ext3_error() that
> replaces the warnings in many places. The behavior is configurable using
> the mount options introduced with the i/o error patches.

Sounds good to me.

>
> -Jeff
>
> --
> Jeff Mahoney
> SuSE Labs

