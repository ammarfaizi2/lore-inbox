Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUHJP6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUHJP6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUHJP6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:58:13 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:27068 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S267480AbUHJP5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:57:08 -0400
Date: Tue, 10 Aug 2004 17:57:01 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dsaxena@plexity.net, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Remove spaces from PCI IDE pci_driver.name field
Message-ID: <20040810155701.GB21534@louise.pinerecords.com>
References: <20040810001316.GA7292@plexity.net> <1092096699.14934.4.camel@localhost.localdomain> <20040810021209.GA10495@plexity.net> <1092138774.16979.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092138774.16979.13.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug-10 2004, Tue, 12:52 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Files w/o spaces look better and is easier to work with if running 
> > from cmd line, but if we ignore the "prettyness" issue, we should at 
> > least try to be consistent. Either we have spaces and _all_ driver 
> > names are in the format "xxx IDE", "xxx i2c", etc, or we don't allow
> > space at all. 
> Any command line tool has to be robust for space handling anyway.

Sure, but while with a GUI you can click on almost anything, on the
command line spaces in filenames have always been a real pain in
the ass, so let's not pretend otherwise.

-- 
Tomas Szepe <szepe@pinerecords.com>
