Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261844AbTCQSRT>; Mon, 17 Mar 2003 13:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbTCQSRO>; Mon, 17 Mar 2003 13:17:14 -0500
Received: from quechua.inka.de ([193.197.184.2]:42716 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S261844AbTCQSQO>;
	Mon, 17 Mar 2003 13:16:14 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: select() stress
References: <Pine.WNT.4.44.0303171010580.1544-100000@GOLDENEAGLE.gameday2000> <Pine.LNX.4.53.0303171112090.22652@chaos>
Organization: private Linux site, southern Germany
Date: Mon, 17 Mar 2003 19:24:58 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E18uzIA-0003Bn-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> select() takes a file-descriptor as its first argument, not the
> return-value of some function that returns the number of file-
> descriptors. You cannot assume that this number is the same
> as the currently open socket. Just use the socket-value. That's
                                                         ^ plus one

(yes, I made that mistake more than enough times...)

Olaf

