Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272836AbTHKQgN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272824AbTHKQfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:35:46 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:20707 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S272799AbTHKQfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:35:07 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [PATCH] remove version.h from bttv
Date: 11 Aug 2003 18:30:54 +0200
Organization: SuSE Labs, Berlin
Message-ID: <87isp45f7l.fsf@bytesex.org>
References: <E19mCuP-0003dj-00@tetrachloride>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1060619454 10450 127.0.0.1 (11 Aug 2003 16:30:54 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@redhat.com writes:

> -#include <linux/version.h>
> +
>  #define BTTV_VERSION_CODE KERNEL_VERSION(0,9,11)
                             ^^^^^^^^^^^^^^

I'm pretty sure this will break the build ...

  Gerd

-- 
sigfault
