Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269097AbUIXTNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269097AbUIXTNz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 15:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269099AbUIXTNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 15:13:55 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:21522 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269097AbUIXTNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 15:13:50 -0400
Date: Fri, 24 Sep 2004 20:13:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Francesco Casadei <fr.casadei@tiscali.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: task_struct reference counting
Message-ID: <20040924201347.C30391@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Francesco Casadei <fr.casadei@tiscali.it>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <4154364F.6060405@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4154364F.6060405@tiscali.it>; from fr.casadei@tiscali.it on Fri, Sep 24, 2004 at 04:59:27PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 04:59:27PM +0200, Francesco Casadei wrote:
> How one is supposed to handle the reference count of a task_struct from a 
> kernel module?

I don't think you are supposed to do anything that'd need to grab a
task_struct from modular code.

