Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVI2VfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVI2VfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbVI2VfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:35:15 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:60894 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1030246AbVI2VfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:35:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Date: Thu, 29 Sep 2005 23:35:37 +0200
User-Agent: KMail/1.8.2
Cc: pavel@ucw.cz, ak@suse.de, linux-kernel@vger.kernel.org
References: <200509281624.29256.rjw@sisk.pl> <20050929130250.4c28af8d.akpm@osdl.org>
In-Reply-To: <20050929130250.4c28af8d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509292335.37638.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 29 of September 2005 22:02, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > The following patch fixes Bug #4959.
> 
> Breaks x86_64 build.

I am sorry for that.  Should have tested without CONFIG_SOFTWARE_SUSPEND
myself.

I'll repost the corrected patch (tested with your .config) in a while.

Greetings,
Rafael
