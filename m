Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbTJWSo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 14:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbTJWSo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 14:44:56 -0400
Received: from smtp2.email.luna.net ([217.77.137.81]:11684 "EHLO
	smtp2.email.luna.net") by vger.kernel.org with ESMTP
	id S261644AbTJWSoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 14:44:54 -0400
Message-ID: <3F98222E.90304@freemail.hu>
Date: Thu, 23 Oct 2003 20:47:10 +0200
From: Chip <szarlada@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8 PROBLEM: codepage=850 doesn't work with mount [SOLVED]
References: <3F97AD01.9030806@freemail.hu>	<871xt3su4n.fsf@devron.myhome.or.jp> <20031023112824.7bb6f0d8.rddunlap@osdl.org>
In-Reply-To: <20031023112824.7bb6f0d8.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Fri, 24 Oct 2003 03:10:00 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> 
> | Chip <szarlada@freemail.hu> writes:
> | 
> | > Hi,
> | > 
> | > If you've got this line in your /etc/fstab:
> | > 
> | > /dev/hda5 /mnt/win_d vfat quiet,iocharset=iso8859-1,codepage=850,umask=0 0 0
> | > 
> | > You will get the following message during mount -a:
> | > 
> | > mount: wrong fs type, bad option, bad superblock on /dev/hda5,
> | >         or too many mounted file systems
> | > 
> | > I've chessed out that the problemataic part is the codepage=850. When
> | > I've removed it the mount goes ok.
> | 
> | I couldn't reproduce it. Could you send output of dmesg and .config.
> | It looks like it couldn't load nls_cp850.
> 
> I second that.  I was just trying to reproduce it and cannot.

Sorry guys, you've got right. I've compiled cp852 instead of cp850.
Execuse me for blaming.

Chip...

