Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbTJWSad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 14:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTJWSad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 14:30:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:30849 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261592AbTJWSac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 14:30:32 -0400
Date: Thu, 23 Oct 2003 11:28:24 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: szarlada@freemail.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8 PROBLEM: codepage=850 doesn't work with mount
Message-Id: <20031023112824.7bb6f0d8.rddunlap@osdl.org>
In-Reply-To: <871xt3su4n.fsf@devron.myhome.or.jp>
References: <3F97AD01.9030806@freemail.hu>
	<871xt3su4n.fsf@devron.myhome.or.jp>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Oct 2003 03:10:00 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

| Chip <szarlada@freemail.hu> writes:
| 
| > Hi,
| > 
| > If you've got this line in your /etc/fstab:
| > 
| > /dev/hda5 /mnt/win_d vfat quiet,iocharset=iso8859-1,codepage=850,umask=0 0 0
| > 
| > You will get the following message during mount -a:
| > 
| > mount: wrong fs type, bad option, bad superblock on /dev/hda5,
| >         or too many mounted file systems
| > 
| > I've chessed out that the problemataic part is the codepage=850. When
| > I've removed it the mount goes ok.
| 
| I couldn't reproduce it. Could you send output of dmesg and .config.
| It looks like it couldn't load nls_cp850.

I second that.  I was just trying to reproduce it and cannot.

--
~Randy
