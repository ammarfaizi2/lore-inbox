Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVAEL02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVAEL02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVAEL01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:26:27 -0500
Received: from [213.146.154.40] ([213.146.154.40]:49296 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262334AbVAELZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:25:57 -0500
Date: Wed, 5 Jan 2005 11:25:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] merge *_vm_enough_memory()s into a common helper
Message-ID: <20050105112554.GB31119@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 03:48:33PM -0600, Serge E. Hallyn wrote:
> The attached patch introduces a __vm_enough_memory function in
> security/security.c which is used by cap_vm_enough_memory,
> dummy_vm_enough_memory, and selinux_vm_enough_memory.  This has
> been discussed on the lsm mailing list.
> 
> Are there any objections to or comments on this patch?

Maybe this function should go into mm/ ?

