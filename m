Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbULAGpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbULAGpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 01:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbULAGpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 01:45:39 -0500
Received: from ems.hclinsys.com ([203.90.70.242]:20485 "EHLO ems.hclinsys.com")
	by vger.kernel.org with ESMTP id S261311AbULAGpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 01:45:34 -0500
Message-ID: <001901c4d771$222bf940$50500897@jagadeesh>
From: "Jagadeesh Bhaskar P" <jbhaskar@hclinsys.com>
To: "Oliver Neukum" <neukum@fachschaft.cup.uni-muenchen.de>
Cc: "LKML" <linux-kernel@vger.kernel.org>
References: <1101879238.7423.13.camel@myLinux> <Pine.LNX.4.58.0412010732330.9205@fachschaft.cup.uni-muenchen.de>
Subject: Re: Query regarding current macro
Date: Wed, 1 Dec 2004 12:13:57 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So the rest of the bits in esp means garbage values?

 On Wed, 1 Dec 2004, Jagadeesh Bhaskar P wrote:
> > I have read that both the kernel stack and process descriptor of a
> > process is stored in together in an 8KB page. Now the offsets in the
> > page should start from all bits 0, rite? So then why masking only the 13
> > bits LSB?? What is the significance of keeping that length at 13??
>
> The stack grows downwards on x86. Thus the lowermost stack entry has all
> bits set. The length is 13 because 13 corresponds to 8K.
>
> HTH
> Oliver

--
Regards,

Jagadeesh Bhaskar P

