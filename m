Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbTBXWiG>; Mon, 24 Feb 2003 17:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbTBXWiF>; Mon, 24 Feb 2003 17:38:05 -0500
Received: from fmr02.intel.com ([192.55.52.25]:37364 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261701AbTBXWiE>; Mon, 24 Feb 2003 17:38:04 -0500
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BB1A@orsmsx107.jf.intel.com>
From: "Moore, Robert" <robert.moore@intel.com>
To: "'Pavel Machek'" <pavel@ucw.cz>, "Moore, Robert" <robert.moore@intel.com>
Cc: "'Bjorn Helgaas'" <bjorn_helgaas@hp.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Walz, Michael" <michael.walz@intel.com>, t-kochi@bq.jp.nec.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: RE: [ACPI] [PATCH] 1/3 ACPI resource handling
Date: Mon, 24 Feb 2003 14:48:06 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, as long as the code is used more than once (which it appears to be),
then of course it should be procedurized.
Bob


-----Original Message-----
From: Pavel Machek [mailto:pavel@ucw.cz] 
Sent: Sunday, February 23, 2003 2:55 PM
To: Moore, Robert
Cc: 'Bjorn Helgaas'; Grover, Andrew; Walz, Michael; t-kochi@bq.jp.nec.com;
linux-kernel@vger.kernel.org; acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling

Hi!

> 1) This seems like a good idea to simplify the parsing of the resource
lists
> 
> 2) I'm not convinced that this buys a whole lot -- it just hides the code
> behind a macro (something that's not generally liked in the Linux world.)
> Would this procedure be called from more than one place?

Well, reducing code duplication *is* liked in Linux world. Use inline
function instead of macro if possible, through.
	
Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
