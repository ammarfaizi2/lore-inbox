Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbTEKR31 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTEKR31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:29:27 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58004
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261759AbTEKR3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:29:21 -0400
Subject: Re: 2.4.21-rc2 IDE Modular non-compile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030511150312.GB5376@louise.pinerecords.com>
References: <20030509064035.4C6612C014@lists.samba.org>
	 <20030509075319.A10102@infradead.org>
	 <20030510102615.GB12431@louise.pinerecords.com>
	 <1052577101.16165.4.camel@dhcp22.swansea.linux.org.uk>
	 <20030511150312.GB5376@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052671379.29920.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 May 2003 17:43:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-05-11 at 16:03, Tomas Szepe wrote:
> The patch (against 2.4.21-rc2-ac1) is rather large, because it
> 	o  moves cmd640.c from drivers/ide/pci to drivers/ide, and
> 	o  deletes cmd640.h as it is no longer used.

Please dont move cmd640, the drivers dont go in the top ide directory

> I'm sure the patch is far from perfect yet (esp. what I did to
> ide-default.c isn't nice at all -- I couldn't see why the object
> was meant to be a module, or maybe I just got lost in untangling the
> reference loops), the result, however, seems to work (for a change).

ide-default is never going to be a module so that bit is ok.

