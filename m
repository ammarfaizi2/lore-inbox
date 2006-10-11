Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030661AbWJKGge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030661AbWJKGge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030663AbWJKGge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:36:34 -0400
Received: from hera.kernel.org ([140.211.167.34]:46569 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030661AbWJKGgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:36:33 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.18 suspend regression on Intel Macs
Date: Wed, 11 Oct 2006 02:37:54 -0400
User-Agent: KMail/1.8.2
Cc: Arjan van de Ven <arjan@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       =?iso-8859-1?q?Fr=E9d=E9ric_Riss?= <frederic.riss@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <1160417982.5142.45.camel@funkylaptop> <1160476889.3000.282.camel@laptopd505.fenrus.org> <20061010212853.GC31972@srcf.ucam.org>
In-Reply-To: <20061010212853.GC31972@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610110237.54906.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 17:28, Matthew Garrett wrote:
> On Tue, Oct 10, 2006 at 12:41:28PM +0200, Arjan van de Ven wrote:
> 
> > "fix" for some value of the word.
> > The problem is that this is very much against the spec, and also quite
> > likely breaks a bunch of machines...
> 
> It works fine under Windows, which suggests that the Windows behaviour 
> is to reenable the bit. 

To me it suggests that both Windows and MacOS provoke the firmware
to re-enable this bit -- it doesn't suggest that the OS is doing it.

> I wouldn't really expect any existing hardware  
> to expect any other sort of behaviour.

I would.  In the known universe, the Mac-mini is the only machine that
seems to need us to explicitly set SCI_EN.

-Len
