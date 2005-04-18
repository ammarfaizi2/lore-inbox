Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVDRQ25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVDRQ25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVDRQ24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:28:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9688 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262105AbVDRQ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:26:32 -0400
Date: Mon, 18 Apr 2005 17:26:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Igor Shmukler <igor.shmukler@gmail.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, riel@redhat.com, thehazard@gmail.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: intercepting syscalls
Message-ID: <20050418162627.GA27430@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Igor Shmukler <igor.shmukler@gmail.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, riel@redhat.com,
	thehazard@gmail.com, arjan@infradead.org,
	linux-kernel@vger.kernel.org
References: <6533c1c905041511041b846967@mail.gmail.com> <1113588694.6694.75.camel@laptopd505.fenrus.org> <6533c1c905041512411ec2a8db@mail.gmail.com> <e1e1d5f40504151251617def40@mail.gmail.com> <6533c1c905041512594bb7abb4@mail.gmail.com> <Pine.LNX.4.61.0504180752220.3232@chimarrao.boston.redhat.com> <6533c1c905041807487a872025@mail.gmail.com> <20050418081726.7d3125bd.rddunlap@osdl.org> <6533c1c90504180920693aa204@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6533c1c90504180920693aa204@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 12:20:06PM -0400, Igor Shmukler wrote:
> I don't think that drivers have to be architecture independent. Why is
> this a problem?

Actually, yes a driver should generally be architecture independent.
There's some exception for things dealing with lowlevel architecture-
dependent things.

> I would even agree that it might be beneficial to develop guidelines
> for developing stackable modules that intercept system calls, but I
> think that reasons beyond races are of less importance.

No, because we have no interest in supporting that.  Explain is your
problem and show us the code and we might find a better design.

