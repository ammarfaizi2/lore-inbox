Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWF0UTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWF0UTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWF0UTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:19:45 -0400
Received: from xenotime.net ([66.160.160.81]:12000 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030336AbWF0UTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:19:43 -0400
Date: Tue, 27 Jun 2006 13:22:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Lukas Jelinek <info@kernel-api.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel API Reference Documentation
Message-Id: <20060627132226.2401598e.rdunlap@xenotime.net>
In-Reply-To: <44A1858B.9080102@kernel-api.org>
References: <44A1858B.9080102@kernel-api.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 21:22:51 +0200 Lukas Jelinek wrote:

> Hello,
> 
> a few months ago I looked for something like "Linux Kernel API Reference
> Documentation". This search was unsuccessful and somebody recommended me
> to generate this documentation from the kernel headers.
> 
> I have used Doxygen for this work. But the headers have needed to be
> preprocessed by 'sed' using some regexp rules (due to various
> incompatible comment formats).
> 
> Now I decide to share the result worldwide. The current generated
> "Kernel API Reference" can be found at http://www.kernel-api.org.
> Although it is very buggy this time I think it may be useful for module
> developers.
> 
> To allow this work to be better, I suggest to establish some rules for
> writing code comments (especially for function prototypes, data
> structures etc.) and to add the comments to the kernel headers. The
> rules should be chosen carefully to be well accepted by various
> documentation generators (at least by Doxygen).

FYI, there are already some kernel-doc rules in
Documentation/kernel-doc-nano-HOWTO.txt.  These rules work with the
doc. generator in the kernel tree (scripts/kernel-doc).
Do you have suggestions for how to make them (the rules) better?
so that the in-tree kernel doc. will improve...

Q2:  what do I get when I download one of the tarballs from kernel-api.org?

Q3:  Can we see your sed scripts?

Thanks,
---
~Randy
