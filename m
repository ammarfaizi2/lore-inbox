Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268104AbUH3Ox7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268104AbUH3Ox7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268452AbUH3Ox7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:53:59 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:32391 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268104AbUH3OtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:49:07 -0400
Date: Mon, 30 Aug 2004 16:50:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Lei Yang <leiyang@nec-labs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>
Subject: Re: Kernel module problem: no version for "struct_module" found
Message-ID: <20040830145047.GA30017@mars.ravnborg.org>
Mail-Followup-To: Lei Yang <leiyang@nec-labs.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>
References: <41333A0C.5090102@nec-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41333A0C.5090102@nec-labs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 10:30:36AM -0400, Lei Yang wrote:
> Hi friends,
> 
> Have been working on a simple kernel module, I've made everything built 
> with kbuild and insmod test.ko. Now it seems that the module has been 
> installed, however, it doesn't seem to work correctly. I get this dmesg:
> 
> kernel: test: no version for "struct_module" found: kernel tainted.
> 
> Experts here - what is struct_module and how to make modules give proper 
> version for it?

First - please post your Makefile.
People often get kbuild stuff wrong.

	Sam
