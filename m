Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbWHUM7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWHUM7X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWHUM7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:59:23 -0400
Received: from ns.firmix.at ([62.141.48.66]:51685 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932306AbWHUM7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:59:21 -0400
Subject: Re: [take9 1/2] kevent: Core files.
From: Bernd Petrovitsch <bernd@firmix.at>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
In-Reply-To: <20060821111335.GA8608@2ka.mipt.ru>
References: <11555364962921@2ka.mipt.ru> <1155536496588@2ka.mipt.ru>
	 <20060816134550.GA12345@infradead.org> <20060816135642.GD4314@2ka.mipt.ru>
	 <20060818104607.GB20816@infradead.org> <20060818112336.GB11034@2ka.mipt.ru>
	 <20060821105637.GB28759@infradead.org>  <20060821111335.GA8608@2ka.mipt.ru>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 21 Aug 2006 14:53:25 +0200
Message-Id: <1156164805.17936.132.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.377 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 15:13 +0400, Evgeniy Polyakov wrote:
[...]
> And what is the difference between

As others already pointed out in this thread:

These are not seen by the C compiler.
> #define A 1
> #define B 2
> #define C 4
> and

These are known by the C compiler and thus usable/viewable in a
debugger.
> enum {
>  A = 1,
>  B = 2,
>  C = 4,
> }
> ?
	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

