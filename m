Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUHSKGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUHSKGt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 06:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUHSKGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 06:06:49 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:17159 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264953AbUHSKGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 06:06:42 -0400
Date: Thu, 19 Aug 2004 11:06:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: alan@lxorguk.ukuu.org.uk, wtogami@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
Message-ID: <20040819110635.A7850@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Markus Lidel <Markus.Lidel@shadowconnect.com>,
	alan@lxorguk.ukuu.org.uk, wtogami@redhat.com,
	linux-kernel@vger.kernel.org
References: <4123E171.3070104@shadowconnect.com> <20040819002448.A3905@infradead.org> <4123E73F.7040409@shadowconnect.com> <20040819104829.A7705@infradead.org> <41247E0E.8030005@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41247E0E.8030005@shadowconnect.com>; from Markus.Lidel@shadowconnect.com on Thu, Aug 19, 2004 at 12:16:46PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 12:16:46PM +0200, Markus Lidel wrote:
> > Then please add more methods.  Multiplexer calls are an extremly bad idea.
> 
> Okay, i prefer type safety too, but i also don't like too many functions...

Please just add a function per thing you want to do.  That's how Linux APIs
work.

