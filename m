Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbUBZNHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbUBZNHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:07:25 -0500
Received: from mail502.nifty.com ([202.248.37.210]:14485 "EHLO
	mail502.nifty.com") by vger.kernel.org with ESMTP id S262783AbUBZNHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:07:22 -0500
To: helgehaf@aitel.hist.no
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to emulate 'chroot /jail/ su httpd -c' ?
From: Tetsuo Handa <a5497108@anet.ne.jp>
References: <200402261956.BEF40183.2B918856@anet.ne.jp>
	<403DEB2B.2030705@aitel.hist.no>
In-Reply-To: <403DEB2B.2030705@aitel.hist.no>
Message-Id: <200402262207.BAE57397.896285B1@anet.ne.jp>
X-Mailer: Winbiff [Version 2.43 (on Trial)]
X-Accept-Language: ja,en
Date: Thu, 26 Feb 2004 22:07:15 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Helge Hafting wrote:
> Tetsuo Handa wrote:
> > 
> > daemon chroot /jail/ su httpd -c $httpd $OPTIONS
> 
> Why don't you simply do the su first, and the chroot later?
> 
> Helge Hafting
> 

Thank you, Hafting.
But only root can chroot, so after su to httpd, can't chroot.
