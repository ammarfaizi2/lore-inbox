Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbUKVXZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbUKVXZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbUKVXXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:23:06 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:37894 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261224AbUKVXVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:21:32 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041122714.taTI3zcdWo5JfuMd@topspin.com>
	<20041122714.AyIOvRY195EGFTaO@topspin.com>
	<20041122225335.GE15634@kroah.com> <52sm71bie2.fsf@topspin.com>
	<20041122230533.GB13083@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 22 Nov 2004 15:21:26 -0800
In-Reply-To: <20041122230533.GB13083@kroah.com> (Greg KH's message of "Mon,
 22 Nov 2004 15:05:33 -0800")
Message-ID: <52fz31bhc9.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][11/12] Add InfiniBand Documentation files
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 23:21:31.0960 (UTC) FILETIME=[00534B80:01C4D0EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> /dev/umad* /dev/ib/umad*

Right now the umad module creates devices with kernel names like
umad0, umad1, etc, but it puts ibdev and port files in sysfs so
userspace can figure out which IB device and port the file corresponds
to.  I would really prefer to have this info reflected in the /dev name...

    Greg> People who do not use udev will not like you.

OK, I guess we will apply to LANANA.

 - R.
