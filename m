Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265865AbUFDQBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUFDQBR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265845AbUFDQBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:01:05 -0400
Received: from [213.146.154.40] ([213.146.154.40]:34470 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265847AbUFDP7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:59:07 -0400
Date: Fri, 4 Jun 2004 16:59:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exec-shield patch for 2.6.7-rc2-bk2, integrated with NX
Message-ID: <20040604155906.GA1378@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20040602210421.GA22011@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602210421.GA22011@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 11:04:21PM +0200, Ingo Molnar wrote:
> 
> Here's the latest exec-shield patch for 2.6.7-rc2-bk2, integrated with
> the 'NX' feature (see the announcement from earlier today):
> 
>   http://redhat.com/~mingo/exec-shield/exec-shield-on-nx-2.6.7-rc2-bk2-A7

Any chance to split this up a bit?  Having the pure non-exec stack
(and maybe heap) would be really nice while the randomization feature are
a litte bit too much security by obscurity for my taste.

