Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbSKNJsO>; Thu, 14 Nov 2002 04:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbSKNJsO>; Thu, 14 Nov 2002 04:48:14 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:40145 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S264815AbSKNJsN>; Thu, 14 Nov 2002 04:48:13 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug
Date: 14 Nov 2002 10:41:54 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnat6vfi.jfl.kraxel@bytesex.org>
References: <20021114032456.46D742C09E@lists.samba.org>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1037270514 19958 127.0.0.1 (14 Nov 2002 10:41:54 GMT)
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  The question is whether to force an /sbin/hotplug change to use the
>  module alias mechanism, or generate the modules.*map files at "make
>  modules_install" time to avoid breakage.  I'm leaning towards #2, but
>  I haven't written it yet (should be simple).

Doing that at modules_install time doesn't work for external drivers
(which are _not_ in the kernel tree) ...

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
