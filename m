Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWGFSJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWGFSJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWGFSJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:09:47 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:46542
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750823AbWGFSJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:09:46 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Thu, 6 Jul 2006 20:10:53 +0200
User-Agent: KMail/1.9.1
References: <20060705114630.GA3134@elte.hu> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org> <Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607062010.53667.mb@bu3sch.de>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       "Linus Torvalds" <torvalds@osdl.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 July 2006 19:52, linux-os (Dick Johnson) wrote:
> int spinner=0;
> 
> funct(){
>      while(spinner)
		barrier();

-- 
Greetings Michael.
