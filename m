Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267438AbTBXU2G>; Mon, 24 Feb 2003 15:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267432AbTBXU1R>; Mon, 24 Feb 2003 15:27:17 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267430AbTBXU1P>;
	Mon, 24 Feb 2003 15:27:15 -0500
Date: Sun, 23 Feb 2003 23:54:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "'Bjorn Helgaas'" <bjorn_helgaas@hp.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Walz, Michael" <michael.walz@intel.com>, t-kochi@bq.jp.nec.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
Message-ID: <20030223225439.GC120@elf.ucw.cz>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC@orsmsx107.jf.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 1) This seems like a good idea to simplify the parsing of the resource lists
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
