Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267703AbUH3LSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267703AbUH3LSt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 07:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUH3LSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 07:18:49 -0400
Received: from box.punkt.pl ([217.8.180.66]:14091 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S267703AbUH3LSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 07:18:03 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: andersen@codepoet.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.8.1
Date: Mon, 30 Aug 2004 13:17:32 +0200
User-Agent: KMail/1.6.2
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <200408292232.14446.mmazur@kernel.pl> <20040830002422.4b634c6c.davem@davemloft.net> <20040830074835.GA12963@codepoet.org>
In-Reply-To: <20040830074835.GA12963@codepoet.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Message-Id: <200408301317.32758.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On poniedzia³ek 30 sierpieñ 2004 09:48, Erik Andersen wrote:
> There is no question that using PAGE_SIZE should be considered
> harmful.  But this particular change to the linux-libc-headers
> makes it easy for the common case (bog standard x86) folk to keep
> using a fixed PAGE_SIZE value, and keep writing crap code which
> is now _guaranteed_ to blow chunks on mips, x86_64, etc.

Good point. I'll switch to using getpagesize() everywhere in a release or two.

-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
