Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVKAGOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVKAGOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 01:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVKAGOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 01:14:41 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:42879 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932378AbVKAGOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 01:14:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Subject: Re: [PATCH] Convert dmasound_awacs to dynamic input_dev allocation
Date: Tue, 1 Nov 2005 01:14:38 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051101020329.GA7773@cse.unsw.EDU.AU> <200511010055.32726.dtor_core@ameritech.net> <20051101060443.GF11202@cse.unsw.EDU.AU>
In-Reply-To: <20051101060443.GF11202@cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511010114.38632.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 01:04, Ian Wienand wrote:
> On Tue, Nov 01, 2005 at 12:55:31AM -0500, Dmitry Torokhov wrote:
> > Now you are leaking memory if something else fails... FOr example when
> > chip is not present.
> 
> Good point.  I guess the original comment is because the final
> dmasound_init() can fail but we'll still have all sorts of memory,
> irq's and io that aren't cleaned up.  So your previous patch probably
> introduces the least problems.
>

Have you tried it by any chance? I'd feel much better pushing it upstream
knowing that it was tested at least once...

-- 
Dmitry
