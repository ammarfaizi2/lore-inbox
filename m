Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVBKIXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVBKIXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 03:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVBKIXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 03:23:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52883 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262217AbVBKIWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:22:41 -0500
Date: Fri, 11 Feb 2005 08:22:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Matt Mackall <mpm@selenic.com>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211082214.GA30420@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Matt Mackall <mpm@selenic.com>,
	Chris Wright <chrisw@osdl.org>, Jack O'Quin <jack.oquin@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Paul Davis <paul@linuxaudiosystems.com>,
	Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
References: <a075431a050210125145d51e8c@mail.gmail.com> <20050211000425.GC2474@waste.org> <20050210164727.M24171@build.pdx.osdl.net> <20050211020956.GC15058@waste.org> <20050211081422.GB2287@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211081422.GB2287@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 09:14:22AM +0100, Ingo Molnar wrote:
> an "RT priorities rlimit" is still not adequate as a desktop solution,
> because it still allows the box to be locked up. Also, if it turns out
> to be a mistake then it's already codified into the ABI, while RT-LSM is
> much less 'persistent' and could be replaced much easier. RT-LSM is also
> more flexible and more practical. (an rlimit needs changes across a
> number of userspace components, delaying its adoptation.)

Putting it into the tree means a gurantee we'll keep it going.  It'd
probably much better if Jack just keepts it separatly.  Especially as
his lack of even making it generic shows that he's unwilling to invest
work into it that doesn't benfit him personally.

