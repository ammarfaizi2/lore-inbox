Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTEHOXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 10:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbTEHOXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 10:23:49 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:34565 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261605AbTEHOXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 10:23:48 -0400
Date: Thu, 8 May 2003 15:36:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030508153622.A9081@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	"viro@parcelfarce.linux.theplanet.co.uk" <viro@parcelfarce.linux.theplanet.co.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Terje Eggestad <terje.eggestad@scali.com>
References: <200305081009_MC3-1-37FA-2408@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305081009_MC3-1-37FA-2408@compuserve.com>; from 76306.1226@compuserve.com on Thu, May 08, 2003 at 10:08:37AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 10:08:37AM -0400, Chuck Ebbert wrote:
>   Meanwhile on Win2k I can intercept any IO request by
> wrting a filter driver,

you can write a stackable filesystem on linux, too and intercept any
I/O request.  You just have to do it through a sane interface, mount
and not by patching the syscall table - which you can do under
windows either.  (at least not as part of the public API).

