Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbTEIHpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 03:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTEIHpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 03:45:06 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:50955 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262335AbTEIHpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 03:45:06 -0400
Date: Fri, 9 May 2003 08:57:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030509085731.A12170@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200305090352_MC3-1-3815-126E@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200305090352_MC3-1-3815-126E@compuserve.com>; from 76306.1226@compuserve.com on Fri, May 09, 2003 at 03:50:31AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 03:50:31AM -0400, Chuck Ebbert wrote:
>   Does a layered filesystem get all requests for ext3 IO if it's above
> it then, or does someone have to manually mount it for each volume?

after you mounted it you get all I/O requests below the mountpoint.

---end quoted text---
