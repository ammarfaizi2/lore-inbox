Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbUKJDhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbUKJDhM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 22:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbUKJDhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 22:37:12 -0500
Received: from siaag1aa.compuserve.com ([149.174.40.3]:18620 "EHLO
	siaag1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S261841AbUKJDhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 22:37:00 -0500
Date: Tue, 9 Nov 2004 22:34:21 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: balance_pgdat(): where is total_scanned ever updated?
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Message-ID: <200411092236_MC3-1-8E5A-C9FD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> There's lots of useful info in /proc/vmstat.

 And the documentation on these fields is the source code itself, right? :)

 The nr_dirty field seems kind of useless -- why not have nr_dirtied
and nr_cleaned instead?  Analysis tools can subtract them to get nr_dirty.
Or is there some other field that shows the nr of pages being dirtied?


--Chuck Ebbert  09-Nov-04  22:13:44
