Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVDFMhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVDFMhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVDFMhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:37:06 -0400
Received: from cpc3-cmbg8-4-0-cust40.cmbg.cable.ntl.com ([82.16.12.40]:49839
	"EHLO cuddles.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S262192AbVDFMhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 08:37:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16979.55221.574028.90931@cuddles.cambridge.redhat.com>
Date: Wed, 6 Apr 2005 13:36:05 +0100
From: Andrew Haley <aph@redhat.com>
To: Christophe Saout <christophe@saout.de>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, gcc@gcc.gnu.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jakub@redhat.com, Gerold Jury <gerold.ml@inode.at>,
       Jan Hubicka <hubicka@ucw.cz>, Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG mm] "fixed" i386 memcpy inlining buggy
In-Reply-To: <1112789157.32279.13.camel@leto.cs.pocnet.net>
References: <200503291542.j2TFg4ER027715@earth.phy.uc.edu>
	<200504021526.53990.vda@ilport.com.ua>
	<1112718844.22591.15.camel@leto.cs.pocnet.net>
	<200504061314.27740.vda@port.imtp.ilyichevsk.odessa.ua>
	<1112789157.32279.13.camel@leto.cs.pocnet.net>
X-Mailer: VM 7.14 under Emacs 21.3.50.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a little difficulty understanding what this is for.  Is it
that gcc's builtin memcpy expander generates bad code, or that older
versions of gcc generate bad code, or what?  gcc generates too much
code?

Andrew.
