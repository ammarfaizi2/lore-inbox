Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWFSME6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWFSME6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWFSME6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:04:58 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:48281 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932390AbWFSME5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:04:57 -0400
Date: Mon, 19 Jun 2006 14:04:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bernd Eckenfels <be-news06@lina.inka.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with "different security models"
In-Reply-To: <E1Fs4bp-00073w-00@calista.eckenfels.net>
Message-ID: <Pine.LNX.4.61.0606191403330.31576@yvahk01.tjqt.qr>
References: <E1Fs4bp-00073w-00@calista.eckenfels.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> -> Enable different security models". When this option is enabled, X
>> starts but when I log in to kde or gnome, X restarts. There is no
>> trace in any logs.

In case you have CONFIG_SECURITY_CAPABILITIES=m, you need to load 
commoncap.ko. I once forgot to do so, and named would not start.

>
>Well, I dont know what option that is, but it is a problem of your
>distribution, not the kernel, most likely. If x restarts, that usually means
>the session had terminated. For example it was missing rights to start the
>session script. If you cant debug that little more specific, you might want
>to let that option off? :)
>

Jan Engelhardt
-- 
