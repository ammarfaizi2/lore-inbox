Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbUK2WfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUK2WfF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbUK2WdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:33:24 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:43503 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261837AbUK2W3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:29:47 -0500
To: Greg KH <greg@kroah.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
X-Message-Flag: Warning: May contain useful information
References: <E1CYqYe-00057g-00@w-gerrit.beaverton.ibm.com>
	<20041129220047.GC19892@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 29 Nov 2004 14:28:32 -0800
In-Reply-To: <20041129220047.GC19892@kroah.com> (Greg KH's message of "Mon,
 29 Nov 2004 14:00:47 -0800")
Message-ID: <527jo4s31r.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH] CKRM: 3/10 CKRM:  Core ckrm, rcfs
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 29 Nov 2004 22:28:32.0763 (UTC) FILETIME=[C24494B0:01C4D662]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Ick.  Don't put a _t at the end of a typedef.  Wrong OS
    Greg> style guide.

Just out of curiousity, who wrote the line

	typedef int __bitwise kobject_action_t;

in <linux/kobject_uevent.h>?  From the changelog it almost looks like
you did it ;)

 - Roland
