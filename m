Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWDVU7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWDVU7g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWDVU7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:59:36 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:9180 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1751195AbWDVU7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:59:35 -0400
Date: Sat, 22 Apr 2006 22:59:32 +0200
From: David Weinehall <tao@acc.umu.se>
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060422205932.GW23222@vasa.acc.umu.se>
Mail-Followup-To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
	Xavier Bestel <xavier.bestel@free.fr>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	"Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <1145549460.23837.156.camel@capoeira> <4447B7D6.4030401@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4447B7D6.4030401@linux.intel.com>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 08:33:26PM +0400, Alexey Starikovskiy wrote:
> Xavier Bestel wrote:
> >There are keyboards with power/sleep buttons. It makes sense they have
> >the same behavior than ACPI buttons.
> Agree, make them behave like ACPI buttons -- remove them from input stream, 
> as they do not belong there...

It's far more sane to have them as normal keys; you might want to remap
them to do something else than to suspend your machine, for instance.


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
