Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbTGJX5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269649AbTGJX5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:57:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43183 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266520AbTGJX4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:56:45 -0400
Date: Thu, 10 Jul 2003 17:02:40 -0700 (PDT)
Message-Id: <20030710.170240.68066537.davem@redhat.com>
To: wa@almesberger.net
Cc: hch@infradead.org, jmorris@intercode.com.au, TSPAT@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030709233707.B6409@almesberger.net>
References: <20030709230637.A6409@almesberger.net>
	<20030709.190656.23035889.davem@redhat.com>
	<20030709233707.B6409@almesberger.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Werner Almesberger <wa@almesberger.net>
   Date: Wed, 9 Jul 2003 23:37:07 -0300
   
   BTW, even of the macros with arguments, about 66% seem to be of
   the "local use only" type.

Ok.

In the first stage, I'd be happy to take patches that extract out
inline functions that get used in only one TCP source file.
Those should be easy to find especially for all of the congestion
control etc. stuff going on in tcp_input.c
