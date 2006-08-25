Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWHYOm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWHYOm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWHYOm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:42:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42717 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932455AbWHYOm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:42:28 -0400
Date: Fri, 25 Aug 2006 15:42:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, utz.bacher@de.ibm.com,
       fpavlic@de.ibm.com, tspat@de.ibm.com, linux-390@vm.marist.edu
Subject: Re: [PATCH 3/3] kthread: convert the s390 qeth driver to use kthread
Message-ID: <20060825144226.GC27364@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, utz.bacher@de.ibm.com,
	fpavlic@de.ibm.com, tspat@de.ibm.com, linux-390@vm.marist.edu
References: <20060824212527.GD30007@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824212527.GD30007@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 04:25:27PM -0500, Serge E. Hallyn wrote:
> Convert the s390 qeth driver, which can be a module, to use kthread
> rather than kernel_thread, whose EXPORT_SYMBOL is deprecated.
> 
> Compiles and boots, and dmesg shows it is in use for eth0.

NACK.  for the rationale see my reply to the lcs patch.

