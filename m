Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWBBK5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWBBK5s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWBBK5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:57:48 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:43099 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750712AbWBBK5r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:57:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nWP+Fxg5yQ+eCWzz6C9iEzGpcLnLWRKwCEDZWHah61WzeU6FFB3EAvCMQyLI+G7xUHPMrgrvVk3XTWQdwDNnEH69sVzmn8GVUYTvrEPyDPCEmKV7Pg2LTQ/Be/FRmuzWjZBRuWRB9xR5orXLYLbpBArDMQJbba3W437x/3zHWFs=
Message-ID: <84144f020602020257g72bda32bkc3d6264495bea2aa@mail.gmail.com>
Date: Thu, 2 Feb 2006 12:57:46 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060202100646.GC1981@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602012245.06328.nigel@suspend2.net>
	 <84144f020602010501k23e7898at82c0f231a2da0ad4@mail.gmail.com>
	 <200602020730.16916.nigel@suspend2.net>
	 <84144f020602011345i2e395336s371786c441b9f5b2@mail.gmail.com>
	 <20060202100646.GC1981@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On St 01-02-06 23:45:15, Pekka Enberg wrote:
> > Is that necessary for the mainline, though? We have only one suspend
> > in the kernel, not "Pavel suspend" and "Nigel suspend", right?

On 2/2/06, Pavel Machek <pavel@ucw.cz> wrote:
> Actually plan is to only have "Rafael suspend" :-). That's basically
> "Pavel suspend" minus the disk writing parts. That is *long* term.

So what's the plan for short-term? Are userspace suspend and suspend
modules mutually exclusive or can they co-exist?

                                 Pekka
