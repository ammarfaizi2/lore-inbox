Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbTJCXcJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbTJCXcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:32:08 -0400
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:20713
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261535AbTJCXcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:32:05 -0400
Subject: RE: [ACPI] down_timeout
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Matthew Wilcox <willy@debian.org>, Yury Umanets <umka@namesys.com>,
       acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <D3A3AA459175A44CB5326F26DA7A189C1C3DD3@orsmsx405.jf.intel.com>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3DD3@orsmsx405.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1065223793.14596.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Sat, 04 Oct 2003 00:29:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-10-03 at 21:29, Moore, Robert wrote:
> I would say that the whole thing is wrong -- the kernel should provide a
> semaphore wait function that includes a timeout parameter.

Thats probably the right thing to fix. A timeout aware version of down()
doesnt actually look too hard.

