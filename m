Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268530AbUIQH1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268530AbUIQH1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUIQHZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:25:43 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:56845 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268533AbUIQHZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:25:20 -0400
Date: Fri, 17 Sep 2004 08:25:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Suspend2 Merge: Get module list.
Message-ID: <20040917082515.C10537@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Andrew Morton <akpm@digeo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1095332772.3855.170.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1095332772.3855.170.camel@laptop.cunninghams>; from ncunningham@linuxmail.org on Thu, Sep 16, 2004 at 09:06:12PM +1000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 09:06:12PM +1000, Nigel Cunningham wrote:
> Hi again.
> 
> This patch adds support for getting a list of currently loaded modules.
> It's used in displaying debugging info:

This is printed in an oops anyway, and if the system doesn't crash a
cat /proc/modules does the same.

