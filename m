Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVBGEmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVBGEmj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 23:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVBGEmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 23:42:39 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:39894 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261316AbVBGEmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 23:42:37 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16902.61875.963828.513606@tut.ibm.com>
Date: Sun, 6 Feb 2005 22:42:27 -0600
To: Kingsley Cheung <kingsley@aurema.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] relayfs crash
In-Reply-To: <20050207030444.GF27268@aurema.com>
References: <41EF4E74.2000304@opersys.com>
	<20050207030444.GF27268@aurema.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kingsley Cheung writes:
 > 
 > To solve the problem I applied a patch similar to the one you posted
 > back in July and it fixed the problem.  Could we consider putting this
 > patch into relayfs? Its similar to the one posted in July 2004, except
 > it also moves clear_readers() before INIT_WORK in relay_release (is
 > that acceptable?).
 > 

Yes, for some reason the July patch never got applied to that (now
outdated) 2.6.10 version of relayfs - either that patch or yours
should fix the problem - thanks for sending it.  In any case, the
version of relayfs you're using is now ancient history - the latest
redux versions of relayfs recently posted to lkml have completely
changed or removed all that code, so you might want to try testing
with the latest patch (which I'm still reworking parts of even now).

Thanks,

Tom


