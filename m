Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267988AbUBRUBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUBRUBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:01:09 -0500
Received: from hera.kernel.org ([63.209.29.2]:34475 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S267988AbUBRUBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:01:04 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: UTF-8 and case-insensitivity
Date: Wed, 18 Feb 2004 20:00:30 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c10g8u$e68$1@terminus.zytor.com>
References: <16434.58656.381712.241116@samba.org> <16435.20457.610841.62521@samba.org> <200402181331.36859.robin.rosenberg.lists@dewire.com> <4033974F.4090706@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077134430 14537 63.209.29.3 (18 Feb 2004 20:00:30 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 18 Feb 2004 20:00:30 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4033974F.4090706@zytor.com>
By author:    "H. Peter Anvin" <hpa@zytor.com>
In newsgroup: linux.dev.kernel
>
> Robin Rosenberg wrote:
> > 
> > I believe (please correct me if this is wrong) that Windows never actually
> > supported any of the UCS-2 code that were in conflict with UTF-16. The cost
> > of this operation was that some of the "private" code blocks of unicode 2.0, i.e. 
> > U+D800..U+DFFF were redefined as "surrogates" in Unicode 3.0 making the 
> > UTF-16 encoding more or less backwards compatible with UCS-2. And it's 
> > UTF-16LE and UCS-2LE, but I suspect you knew that :-)
> > 
> 
> Make that Unicode 1.0 and 1.1, and you're correct.
> 

Err, that was supposed to be 1.1 and 2.0.

Unicode 1.1 reshuffled the private use range from Unicode 1.0, in
order to make room for surrogates in Unicode 2.0.

UTF-16, what a horrible ugly hack.

	-hpa
