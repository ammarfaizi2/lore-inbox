Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUI0Hgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUI0Hgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 03:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUI0Hgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 03:36:46 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:52761
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S263736AbUI0Hgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 03:36:45 -0400
Message-Id: <s157d11c.078@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Mon, 27 Sep 2004 09:37:10 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: i386 entry.S problems
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Christoph Hellwig <hch@infradead.org> 24.09.04 21:12:51 >>>
>> +#if !defined(CONFIG_REGPARM) || __GNUC__ < 3
>>  	pushl %ebp
>> +#endif
>
>CONFIG_REGPARM n eeds gcc 3.0 or later

Not sure what you try to point out here: the additions account for
exactly that.


