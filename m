Return-Path: <linux-kernel-owner+w=401wt.eu-S932720AbWLZQsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbWLZQsd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 11:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWLZQsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 11:48:33 -0500
Received: from terminus.zytor.com ([192.83.249.54]:58405 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932720AbWLZQsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 11:48:32 -0500
Message-ID: <45915218.7000004@zytor.com>
Date: Tue, 26 Dec 2006 08:47:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, hpa@zytor.com,
       webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <20061216203000.GB31619@flint.arm.linux.org.uk>
In-Reply-To: <20061216203000.GB31619@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Ergo, downloads via http from ftp.uk.kernel.org are at best unreliable
> for multiple requests.
> 
> I agree that it's not directly your problem, and isn't something you
> have direct control over.  However, if you want to round-robin the
> <cc>.kernel.org IP addresses between different providers, I suggest
> that either the name resolves to just one site, or that kernel.org
> adopts a policy with their mirrors that they only become part of
> the <cc>.kernel.org DNS entries as long as they do not rewrite their
> site-specific URLs in terms of that address.
> 

Indeed.  I just sent a complaint about this, and if we can figure out a 
decent way to test for this automatically we'll add it to our automatic 
tests.

There is also always ftp.

	-hpa
