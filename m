Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVKOMBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVKOMBK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 07:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVKOMBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 07:01:10 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:51336 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932372AbVKOMBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 07:01:08 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: Robin Holt <holt@sgi.com>
Cc: "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, hch@infradead.org
In-Reply-To: <20051115111731.GA9976@lnx-holt.americas.sgi.com>
References: <20051114212341.724084000@sergelap>
	 <20051115111731.GA9976@lnx-holt.americas.sgi.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 13:01:04 +0100
Message-Id: <1132056064.6108.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 05:17 -0600, Robin Holt wrote:
> Can't you just build a restart preloader which intercepts system calls
> and translates pids?  Wouldn't this keep the kernel simpler and only
> affect those applications that are being restarted?  Christoph, I
> added you since you seem to tirelessly promote using preloaders to
> work around this type of issue.  Is it possible?

Statically linked applications really throw a pretty big monkey wrench
into that kind of plan.  I'd hate to give up on _any_ statically linked
app from the beginning.

-- Dave

