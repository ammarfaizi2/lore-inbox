Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263180AbVCXTlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbVCXTlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVCXTlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:41:04 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:24337 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263180AbVCXTj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:39:56 -0500
To: John Richard Moser <nigelenki@comcast.net>
Cc: ubuntu-devel <ubuntu-devel@lists.ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: vfat broken in 2.6.10?
References: <4241E3EA.4080501@comcast.net>
	<87fyyl3war.fsf@devron.myhome.or.jp> <42430C26.6000603@comcast.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 25 Mar 2005 04:39:42 +0900
In-Reply-To: <42430C26.6000603@comcast.net> (John Richard Moser's message of
 "Thu, 24 Mar 2005 13:51:18 -0500")
Message-ID: <87psxokf41.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser <nigelenki@comcast.net> writes:

> I would really, but I haven't mastered creating debian packages yet; on
> Gentoo I just wrote ebuilds whenever I wanted to test something, then
> uninstalled it if it broke.  Maybe someone else can do it. . . .

dosfstools is simple, so you don't need to install it....

    $ mkdir test
    $ cd test
    $ wget http://user.parknet.co.jp/hirofumi/tmp/fatfsprogs.tar.bz2
    $ tar xjf fatfsprogs.tar.bz2 
    $ cd fatfsprogs/dosfstools-2.10/
    $ make
    $ ./dosfsck/dosfsck /dev/test_device
      [...]
    $ cd ../../..
    $ rm -rf test
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
