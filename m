Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUGIUr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUGIUr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUGIUr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:47:57 -0400
Received: from [213.146.154.40] ([213.146.154.40]:11697 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264386AbUGIUr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:47:56 -0400
Date: Fri, 9 Jul 2004 21:47:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>
Cc: bastian@waldi.eu.org, linux-kernel@vger.kernel.org, davem@redhat.com
Message-ID: <20040709204751.GA5669@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= <yoshfuji@linux-ipv6.org>,
	bastian@waldi.eu.org, linux-kernel@vger.kernel.org,
	davem@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Okay... Let's remove generate_eui64 part instead.
> Something like this. Thanks.

Rather remove it completely.  As that interface has been vetoed the code
is totally useless in mainline.  When IBM comes up with a better interface
they can patch it for that one.

