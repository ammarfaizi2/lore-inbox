Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWJRKYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWJRKYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWJRKYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:24:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46002 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751456AbWJRKYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:24:38 -0400
Date: Wed, 18 Oct 2006 11:24:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make <linux/personality.h> userspace proof
Message-ID: <20061018102433.GB1767@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20061017155526.GA9888@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017155526.GA9888@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 04:55:26PM +0100, Ralf Baechle wrote:
> <linux/personality.h> contains the constants for personality(2) but also
> some defintions that are useless or even harmful in userspace such as
> the personality() macro.

NACK.  glibc has a <sys/personality.h> for that.  It's been there since
at least glibc 2.3.

