Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWECCet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWECCet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 22:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWECCet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 22:34:49 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:16272 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965072AbWECCes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 22:34:48 -0400
Message-ID: <346623686.13008@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Wed, 3 May 2006 10:35:05 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060503023505.GB5915@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nigel Cunningham <nigel@suspend2.net>, Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
References: <20060502075049.GA5000@mail.ustc.edu.cn> <20060502191000.GA1776@elf.ucw.cz> <200605030936.18606.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605030936.18606.nigel@suspend2.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 09:36:12AM +1000, Nigel Cunningham wrote:
> > Could we use this instead of blockdev freezing/big suspend image
> > support? It should permit us to resume quickly (with small image), and
> > then do readahead. ... that will give us usable machine quickly, still
> > very responsive desktop after resume?
> 
> Unrelated to bdev freezing, and will involve far more seeking than reading a 
> contiguous image (as they normally are).

Yes, needs more pondering on this issue...
