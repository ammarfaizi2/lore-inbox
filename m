Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281990AbRKUXPU>; Wed, 21 Nov 2001 18:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281991AbRKUXPL>; Wed, 21 Nov 2001 18:15:11 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:34690 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S281990AbRKUXOy>;
	Wed, 21 Nov 2001 18:14:54 -0500
Message-ID: <3BFC3567.8CC3023F@pobox.com>
Date: Wed, 21 Nov 2001 15:14:47 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ext3 not supported by kernel !!!!!
In-Reply-To: <EXCH01SMTP01eaCYPct00001063@smtp.netcabo.pt>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Maria Godinho de Matos wrote:

> Hi again guys, i manage to compile the 2.4.14 kernel just fine, and did all
> the steps:
>
> Then i rebooted and was expecting a happy ending though it not happened.
> after loading the kernel, when linux was suppose to mount the modules, the
> file system and so, an error appeard!!
>
> fs ext3 not supported by kernel

ext3 is not supported by 2.4.14 -

However you have some options here.

- Get the ext3 kernel patches from Andrew Morton's site
- Update your kernel to 2.4.15-pre8, which has ext3 support
- Edit your fstab to mount the filesystems as type "auto" not ext3

cu

jjs

