Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266240AbUHWR4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUHWR4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUHWR4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:56:07 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:32520 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266240AbUHWR4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:56:00 -0400
Date: Mon, 23 Aug 2004 18:55:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Christoph Hellwig <hch@infradead.org>, alan@lxorguk.ukuu.org.uk,
       wtogami@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
Message-ID: <20040823185554.B19476@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Markus Lidel <Markus.Lidel@shadowconnect.com>,
	alan@lxorguk.ukuu.org.uk, wtogami@redhat.com,
	linux-kernel@vger.kernel.org
References: <4123E171.3070104@shadowconnect.com> <20040819002448.A3905@infradead.org> <4123E73F.7040409@shadowconnect.com> <20040819104829.A7705@infradead.org> <41247E0E.8030005@shadowconnect.com> <20040819110635.A7850@infradead.org> <4124950B.1090706@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4124950B.1090706@shadowconnect.com>; from Markus.Lidel@shadowconnect.com on Thu, Aug 19, 2004 at 01:54:51PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 01:54:51PM +0200, Markus Lidel wrote:
> I still liked the multiplexer approach more, because there where much 
> less copy-and-paste code :-)
> 
> But is it okay for you now?

Yes, looks better.  mid-term we should look into some helper macros
to reduce the clutter and get locking right, but for now that patch
should do it.

