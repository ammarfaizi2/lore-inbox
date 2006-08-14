Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWHNQ7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWHNQ7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWHNQ7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:59:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:12733 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932392AbWHNQ7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:59:34 -0400
Subject: Re: VMPLIT question
From: Dave Hansen <haveblue@us.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: mlord@pobox.com, axboe@suse.de, sam@ravnborg.org, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060812191619.GE4919@us.ibm.com>
References: <20060812052744.GB4919@us.ibm.com>
	 <1155393875.7574.88.camel@localhost.localdomain>
	 <20060812191619.GE4919@us.ibm.com>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 09:59:06 -0700
Message-Id: <1155574746.7574.158.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-12 at 12:16 -0700, Nishanth Aravamudan wrote:
> > You need to ask for help with the high-level option, not the actual
> > "choice":
> 
> The "high-level option" being ...?

In menuconfig, at least:

	"Memory split (3G/1G user/kernel split)  --->"

Inside of "Processor type and features".

> What did you search for in menuconfig
> to get the following? And, in any case, how is it useful to return a
> "(null)" symbol name? 

The trouble is that the help text is associated with the top-level
"choice" Kconfig entry, not the _individual_ choices.  There is no
symbol associated with the top-level one.  It might be useful to allow
help text to be associated with individual "choice" entries, to display
that text in the high-level option, and to replace the "null" symbol
with something that says "this choice can select any of these symbols:
FOO, BAR, etc..."

I'm sure the Kconfig folks take patches. :P

-- Dave

