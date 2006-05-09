Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWEIMBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWEIMBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 08:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWEIMBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 08:01:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58565 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932399AbWEIMBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 08:01:14 -0400
Date: Tue, 9 May 2006 13:01:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
Message-ID: <20060509120113.GB2213@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
	Ian Pratt <ian.pratt@xensource.com>,
	Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085201.799981000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085201.799981000@sous-sol.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:00:35AM -0700, Chris Wright wrote:
> The block device frontend driver allows the kernel to access block
> devices exported exported by a virtual machine containing a physical
> block device driver.

Any reason you're using the old crappy xen I/O code instead of Rusty's
alternative version?

Also please stop this stupid front/back naming.  In Linux terminology the
frontend is the client if there's a need for a postfix at all, and the
backend the server.  Compare that to e.g. ibm vio.
