Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262875AbVGHVd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbVGHVd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbVGHVaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:30:03 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:9732 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262881AbVGHV21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:28:27 -0400
Date: Fri, 8 Jul 2005 23:35:13 +0200
To: Jeremy Nickurak <atrus@lkml.spam.rifetech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
Message-ID: <20050708213513.GA6341@aitel.hist.no>
References: <E1DqhZV-0004yW-00@calista.eckenfels.6bone.ka-ip.net> <1120836958.16935.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120836958.16935.1.camel@localhost>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 09:35:58AM -0600, Jeremy Nickurak wrote:
> On ven, 2005-07-08 at 03:22 +0200, Bernd Eckenfels wrote:
> > No, it is creating files by appending just like any other file write. One
> > could think about a call to create unfragmented files however since this is
> > not always working best is to create those files young or defragment them
> > before usage.
> 
> Except that this defeats one of the biggest advantages a swap file has
> over a swap partition: the ability to easilly reconfigure the amount of
> hd space reserved for swap.

You can still reconfigure the amount of swap by creating more swapfiles
later - you merely risk a fragmented file.  Keep your filesystems only
half full though, and it won't be a big problem. 
:-)

Helge Hafting

