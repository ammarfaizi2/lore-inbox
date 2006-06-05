Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932394AbWFECvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWFECvu (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 22:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWFECvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 22:51:50 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:26738 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932394AbWFECvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 22:51:50 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: [PATCH] Use ld's garbage collection feature
Date: Sun, 4 Jun 2006 22:51:45 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Arjan van de Ven <arjan@linux.intel.com>
References: <20060605003152.GA1364@dmt>
In-Reply-To: <20060605003152.GA1364@dmt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606042251.46575.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 June 2006 20:31, Marcelo Tosatti wrote:
> Current implementation requires "make modules" to be run before "make
> vmlinux" (need to know what functions used by modules must be kept), but
> 

How will it work with out of tree modules? Or even modules one decides
to add later and use without rebooting?

-- 
Dmitry
