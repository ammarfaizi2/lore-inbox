Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTIRHFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 03:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTIRHFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 03:05:37 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:5903 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262991AbTIRHFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 03:05:37 -0400
Date: Thu, 18 Sep 2003 08:05:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Barnes <jbarnes@sgi.com>, pfg@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix console driver
Message-ID: <20030918080533.A12519@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@sgi.com>,
	pfg@sgi.com, linux-kernel@vger.kernel.org
References: <20030917222414.GA25931@sgi.com> <20030917152139.42a1ce20.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030917152139.42a1ce20.akpm@osdl.org>; from akpm@osdl.org on Wed, Sep 17, 2003 at 03:21:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 03:21:39PM -0700, Andrew Morton wrote:
> Would it be more appropriate to place this under arch/ia64?

arch/ drivers are evil.  Also the driver could possibly used on mips
if someone does the port to this hardware..

