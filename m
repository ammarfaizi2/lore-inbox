Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTEGVdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbTEGVdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:33:00 -0400
Received: from mail.hometree.net ([212.34.181.120]:49348 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S264281AbTEGVc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:32:57 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Date: Wed, 7 May 2003 21:45:31 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b9bupr$jkm$2@tangens.hometree.net>
References: <20030507084920.GA823@suse.de> <Pine.LNX.4.44.0305070915470.2726-100000@home.transmeta.com> <20030507164613.GN823@suse.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1052343931 20118 212.34.181.4 (7 May 2003 21:45:31 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 7 May 2003 21:45:31 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

>I dunno what the purpose of that would be exactly, I guess to cater to
>some hardware odditites?

Wild guess: You can use larger transfer sizes with the 48 bit
interface, even when adressing the lower 28 bit space?

This might be a win for applications that stream large contigous
blocks from/to a HD (Video, Audio...)

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
