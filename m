Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTEWFMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 01:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTEWFMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 01:12:31 -0400
Received: from pat.uio.no ([129.240.130.16]:9460 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263620AbTEWFMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 01:12:30 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, torvalds@transmeta.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [patch?] truncate and timestamps
References: <UTC200305230017.h4N0Hqn05589.aeb@smtp.cwi.nl>
	<Pine.LNX.4.44.0305221726300.19226-100000@home.transmeta.com>
	<20030523011751.GC14406@parcelfarce.linux.theplanet.co.uk>
	<20030522194211.4191e473.akpm@digeo.com>
	<shsvfw29ri2.fsf@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 23 May 2003 07:25:26 +0200
In-Reply-To: <shsvfw29ri2.fsf@charged.uio.no>
Message-ID: <shsy90yi69l.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     > As far as NFS is concerned, we should only be setting
     > ATTR_*TIME if/when the *user* specifies it through a utimes()
     > call or something like that.

Duh... errno = -ENOCOFFEE;

I'm confusing ATTR_*TIME and ATTR_*TIME_SET...

Cheers,
  Trond
