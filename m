Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVFFBG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVFFBG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 21:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVFFBG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 21:06:59 -0400
Received: from animx.eu.org ([216.98.75.249]:42167 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261154AbVFFBG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 21:06:58 -0400
Date: Sun, 5 Jun 2005 21:02:46 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: Easy trick to reduce kernel footprint
Message-ID: <20050606010246.GA22252@animx.eu.org>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	linux-kernel@vger.kernel.org, mpm@selenic.com
References: <20050605223528.GA13726@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050605223528.GA13726@alpha.home.local>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Here's a simple trick for all those who try to squeeze their kernels to the
> absolute smallest size.
> 
> I recently discovered p7zip which comes with the LZMA compression algorithm,
> which is somewhat better than gzip and bzip2 on most datasets, and I also
> noticed that this tool provides support for gzip and bzip2 outputs. So I tried
> to produce some of those standard outputs, and observed a slight gain compared
> to the default tools. The reason is that we can change the number of passes and
> the dictionnary size.

Is it any smaller than a UPX'd kernel?  (I think you need the beta version. 
I know the upx-ucl in debian won't compress but upx-ucl-beta will if you
force).  I got a significant reduction using it.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
