Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265556AbVBDXhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265556AbVBDXhG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbVBDXhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:37:05 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:59864 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265556AbVBDXei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:34:38 -0500
Date: Sat, 5 Feb 2005 00:31:53 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Stelian Pop <stelian@popies.net>, lm@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
Message-ID: <20050204233153.GA28731@electric-eye.fr.zoreil.com>
References: <20050203202049.GC20389@bitmover.com> <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com> <20050204130127.GA3467@crusoe.alcove-fr> <20050204160631.GB26748@bitmover.com> <20050204170306.GB3467@crusoe.alcove-fr> <20050204183922.GC27707@bitmover.com> <20050204200507.GE5028@deep-space-9.dsnet> <20050204201157.GN27707@bitmover.com> <20050204214015.GF5028@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204214015.GF5028@deep-space-9.dsnet>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian@popies.net> :
[...]
> Now, suppose one of my patches introduced a problem. How can someone
> not using BK isolate the patch which introduced the problem ? All he
> can do is to back out the entire set of patches, and the whole point
> of having split the patch initialy into logical changes is lost.

Nope: he digs the bk-commit mailing list archives.

For example, from Roland's mail
2005/01/31 01:37:39-05:00 len.brown
2005/01/31 01:35:48-05:00 len.brown
2005/01/31 00:15:20-05:00 len.brown
2005/01/31 00:12:40-05:00 len.brown
[etc.]

$ grep +/^ChangeSet.*2005/01/31.*len.brown ~/Mail/linux/bk-commit/200505
ChangeSet 1.1983.5.2, 2005/01/31 00:15:20-05:00, len.brown@intel.com
ChangeSet 1.1938.498.11, 2005/01/31 00:12:40-05:00, len.brown@intel.com
ChangeSet 1.1983.5.3, 2005/01/31 01:37:39-05:00, len.brown@intel.com
ChangeSet 1.1938.498.12, 2005/01/31 01:35:48-05:00, len.brown@intel.com

Same thing as in Roland's mail but the changes are isolated.

--
Ueimor
