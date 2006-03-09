Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751968AbWCIX2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbWCIX2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbWCIX2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:28:22 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:13473 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751968AbWCIX2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:28:21 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core driver
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:28:16 -0800
In-Reply-To: <71644dd19420ddb07a75.1141922823@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:47:03 -0800")
Message-ID: <ada4q27fban.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:28:16.0713 (UTC) FILETIME=[248DB390:01C643D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> I suspect that our use of SetPageReserved in
    Bryan> ipath_file_ops.c may be causing us problems, but I am not
    Bryan> sure what correct behaviour would look like.  Suggestions
    Bryan> appreciated.

Why are you doing SetPageReserved?  As I understand things, the
reserved bit is deprecated because it doesn't really have any defined
semantics...

 - R.
