Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262957AbUJ2Dlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbUJ2Dlx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 23:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbUJ2Dlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 23:41:53 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:30988 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262949AbUJ2DlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 23:41:11 -0400
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, Nigel Kukard <nkukard@lbsd.net>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: 2.6.9bk6 msdos fs OOPS
References: <41809921.10200@lbsd.net>
	<200410281432.01013.gene.heskett@verizon.net>
	<87zn261v1b.fsf@devron.myhome.or.jp>
	<200410281905.20547.gene.heskett@verizon.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 29 Oct 2004 09:01:50 +0900
In-Reply-To: <200410281905.20547.gene.heskett@verizon.net> (Gene Heskett's
 message of "Thu, 28 Oct 2004 19:05:20 -0400")
Message-ID: <87k6ta1jf5.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

> Not at the time, which is why I came to the conclusion it may be a bug 
> in the camera software.  It checks in as version 1.0, and we all know 
> no one trusts anything at version 1.0. :-)
>
> I know now how to keep it from happening, so its not a showstopper for 
> me.

Can you check the camera's entry of "cat /proc/mounts"?  Is it
something like, "/dev/sda1 /mnt vfat ro,..."?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
