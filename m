Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWHQXlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWHQXlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWHQXlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:41:36 -0400
Received: from rs02.intra2net.com ([81.169.173.116]:8454 "EHLO
	rs02.intra2net.com") by vger.kernel.org with ESMTP id S1030391AbWHQXlf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:41:35 -0400
From: "Gerd v. Egidy" <gerd.von.egidy@intra2net.com>
Organization: Intra2net AG
To: Willy Tarreau <w@1wt.eu>
Subject: Re: Linux 2.4.34-pre1
Date: Fri, 18 Aug 2006 01:41:19 +0200
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, Mikael Pettersson <mikpe@csd.uu.se>,
       Andreas Steinmetz <ast@domdv.de>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com
References: <20060816223633.GA3421@hera.kernel.org> <20060817124839.GR7813@stusta.de> <20060817204307.GA17391@1wt.eu>
In-Reply-To: <20060817204307.GA17391@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608180141.20040.gerd.von.egidy@intra2net.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

first thank you for continuing work for 2.4, our company still relies on it 
for a lot of machines.

> By this time, those people obviously know that they will have more
> and more problems getting 2.4 to run reliably on fresh new hardware.

Yes, we've already experienced problems with new hw. We could solve most of 
the stuff with some vendor supplied patches. But now we got performance 
problems with ICH7 SATA performance: a disk does only about 11MB/s on 2.4 
with all 2.4 patches from Jeff applied while we get about 40MB/s on 2.6.16. 
Backporting the libata changes done between 2.6.15 (I think that is about the 
same codebase as the current 2.4 stuff) and 2.6.16 seems like a big task.

So my question is: what is your policy on new or enhanced drivers (not just 
new pciids)?

Kind regards,

Gerd
