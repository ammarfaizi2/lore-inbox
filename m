Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUFVOnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUFVOnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUFVOhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:37:22 -0400
Received: from [213.146.154.40] ([213.146.154.40]:53382 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263375AbUFVOfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:35:07 -0400
Date: Tue, 22 Jun 2004 15:35:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Jackson <pj@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, cw@f00f.org, dcn@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add wait_event_interruptible_exclusive() macro
Message-ID: <20040622143505.GA3727@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Jackson <pj@sgi.com>, cw@f00f.org, dcn@sgi.com,
	linux-kernel@vger.kernel.org
References: <40D30646.mailxA8X155I80@aqua.americas.sgi.com> <20040622120130.GA16246@taniwha.stupidest.org> <20040622122948.GA2038@infradead.org> <20040622063537.33282647.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622063537.33282647.pj@sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 06:35:37AM -0700, Paul Jackson wrote:
> Are you referring to such usages as the "&wq" in this line:

No.  The real issue is how we use the condition argument.  in most users
that's no a simple variable but a complex statatement.

