Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWDTVW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWDTVW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 17:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWDTVW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 17:22:58 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:33191 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1751317AbWDTVW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 17:22:57 -0400
Date: Fri, 21 Apr 2006 01:22:27 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
       Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060421012227.A16574@jurassic.park.msu.ru>
References: <20060419213129.GA9148@localhost> <20060419215803.6DE5BDBA1@gherkin.frus.com> <20060420101448.GA20087@localhost> <20060420171102.GA7272@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060420171102.GA7272@localhost>; from mchouque@free.fr on Thu, Apr 20, 2006 at 07:11:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 07:11:02PM +0200, Mathieu Chouquet-Stringer wrote:
> Replying to myself here, i've created the following test program and
> redefined strncpy to mystrncpy (I used strncpy.S and stxncpy.S from
> arch/alpha/lib):

...

> And here's the output using gcc version 3.4.4 (Gentoo 3.4.4-r1,
> ssp-3.4.4-1.0, pie-8.7.8), note i didn't use flag except -Wall:
> 
> fails for strlen = 3 (copied 2)
> fails for strlen = 4 (copied 2)

I'm unable to reproduce this with the toolchains that I have.

Ivan.
