Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSKNKnV>; Thu, 14 Nov 2002 05:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSKNKnV>; Thu, 14 Nov 2002 05:43:21 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:33555 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264838AbSKNKnU>; Thu, 14 Nov 2002 05:43:20 -0500
Date: Thu, 14 Nov 2002 10:50:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, kaos@ocs.com.au,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: Modules in 2.5.47-bk...
Message-ID: <20021114105010.A22135@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Jeff Garzik <jgarzik@pobox.com>, kaos@ocs.com.au,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
References: <3DD2BEBB.8040003@pobox.com> <20021114032456.381C42C06E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021114032456.381C42C06E@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Nov 14, 2002 at 02:53:50PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 02:53:50PM +1100, Rusty Russell wrote:
> The current method is that on "make install" the module-init-tools
> move the old ones to xxx.old (if they exist), and do a backwards
> compat check every time they start (and execvp xxx.old on every older
> kernel).  If it doesn't work for you, please report.

Which breaks nicely every package manager database.

