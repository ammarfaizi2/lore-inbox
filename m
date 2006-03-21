Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWCUKPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWCUKPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 05:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWCUKPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 05:15:19 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63650 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932384AbWCUKPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 05:15:18 -0500
Subject: RE: Lindent and coding style
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673054C365C@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673054C365C@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Mar 2006 10:22:17 +0000
Message-Id: <1142936537.21455.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-21 at 10:55 +0800, Li Yang-r58472 wrote:
> > It should produce suitable output. Do you have examples of where it
> > produces space indentation and you expect tabs ?
> As Jiri has said, it produces code like
> <tab>	if (very long condition &&
> <tab>   ssss2nd condition)...
> The indent command will align the second line at the next character of the left parentheses it belongs to.  In my opinion, this approach makes code more readable.  However, it does not comply with the coding style of kernel.

Lots of the kernel uses exactly that format (probably because of indent)
so I wouldn't worry personally. The CodingStyle document is a guide not
a formal specification.

