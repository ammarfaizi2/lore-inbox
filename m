Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTIZWqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 18:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTIZWqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 18:46:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:4772 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261687AbTIZWqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 18:46:15 -0400
Date: Fri, 26 Sep 2003 15:46:11 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test5-bk(today)] Badness in pci_find_subsys
Message-ID: <20030926224611.GA18896@kroah.com>
References: <20030926203815.GA31674@neon.pearbough.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030926203815.GA31674@neon.pearbough.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 10:38:15PM +0200, Axel Siebenwirth wrote:
> I guess this will help noone I guess, because my kernel is tainted with
> nvidia module and the problem seems to originate from there. Does it?
> Probably you don't even wanna see it, but still I believe
> maybe this could be of help to someone.

Tell nvidia to fix their code.  They are calling a function that they
shouldn't be from interrupt context.  This is not a kernel problem.

thanks,

greg k-h
