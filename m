Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbWFJOmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbWFJOmZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 10:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWFJOmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 10:42:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22710 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030425AbWFJOmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 10:42:24 -0400
Date: Sat, 10 Jun 2006 15:42:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       weihs@ict.tuwien.ac.at, "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread conversion: convert ieee1394 from kernel_thread
Message-ID: <20060610144205.GA13850@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>, bcollins@debian.org,
	linux1394-devel@lists.sourceforge.net, weihs@ict.tuwien.ac.at,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <20060610143100.GA15536@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610143100.GA15536@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 09:31:00AM -0500, Serge E. Hallyn wrote:
> Convert ieee1394 from using deprecated kernel_thread to
> kthread api.
> 
> Compiles fine, but unfortunately I am unable to test.

This patch does various things wrong or at least suboptimal.  See
'[PATCH] ieee1394_core: switch to kthread API' sent to the ieee1394-devel
list on the 14th of April for a patch the gets the formalisms right,
although I wasn't able to test it either.

