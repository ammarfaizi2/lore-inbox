Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280838AbRKYMJ7>; Sun, 25 Nov 2001 07:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280843AbRKYMJt>; Sun, 25 Nov 2001 07:09:49 -0500
Received: from mail3.home.nl ([213.51.129.227]:23537 "EHLO mail3.home.nl")
	by vger.kernel.org with ESMTP id <S280838AbRKYMJj>;
	Sun, 25 Nov 2001 07:09:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Fred Bulthuis <bulthuis@home.nl>
Reply-To: bulthuis@home.nl
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
Date: Sun, 25 Nov 2001 13:09:38 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011125120901.ZWJP28604.mail3.home.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001, F.H. Bulthuis wrote:

> After compiling and installing the new 2.4.16-pre1 uname -a reports
> here version 2.4.15-greased-turkey, not 2.4.16-pre1.

Looks like it was a local problem. Some strange behaviour of a symlink 
/usr/src/linux pointing at /usr/src/linux-2.4.16-pre1. But when I entered 
/usr/src/linux and did a make menuconfig, make dep etc. it started building 
in the linux-2.4.15 directory. Don't know if that's a local fs corruption, 
but after entering the /usr/src/linux-2.4.16-pre1 directory it builds correct.

Fred Bulthuis.
