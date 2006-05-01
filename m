Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWEARWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWEARWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWEARWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:22:48 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:13688 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932168AbWEARWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:22:47 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8 of 13] ipath - fix a number of RC protocol bugs
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1145913776@eng-12.pathscale.com>
	<fafcc38877ad194f3a7a.1145913784@eng-12.pathscale.com>
	<20060425005654.4c08481f.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 10:22:45 -0700
In-Reply-To: <20060425005654.4c08481f.akpm@osdl.org> (Andrew Morton's message of "Tue, 25 Apr 2006 00:56:54 -0700")
Message-ID: <adar73dwtga.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 May 2006 17:22:46.0712 (UTC) FILETIME=[DD25DB80:01C66D43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> Please don't play around with list_head internals like
    Andrew> this - some speedfreak might legitimately choose to remove
    Andrew> the list_head poisoning debug code, or make it
    Andrew> Kconfigurable.

Bryan, can you fix this up and resend this patch?

Are the other patches independent of this?  Should I apply all the
others, or do I need to wait for the fixed version of this one?

 - R.
