Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267942AbUHFNzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267942AbUHFNzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267794AbUHFNzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:55:35 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:32524 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266493AbUHFNza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:55:30 -0400
Date: Fri, 6 Aug 2004 14:55:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Owens <kaos@sgi.com>
Cc: Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Altix I/O code reorganization
Message-ID: <20040806145528.A10251@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Keith Owens <kaos@sgi.com>, Pat Gefre <pfg@sgi.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20040806141836.A9854@infradead.org> <8831.1091800314@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8831.1091800314@ocs3.ocs.com.au>; from kaos@sgi.com on Fri, Aug 06, 2004 at 11:51:54PM +1000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 11:51:54PM +1000, Keith Owens wrote:
> No.  We have had this discussion before - kdb is an extensible
> debugger.  Subsystems can add their own kdb commands to decode their
> own data.  Those extensions to kdb belong in the subsystem code, not in
> the main kdb patch.

They do not belong into mainline.  kdb isn't in mainline and we shouldn't
carry code for it around.  I don't care whether you want it in the kdb patch
or whatether it's in a separate one.
