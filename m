Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267078AbTAFRSX>; Mon, 6 Jan 2003 12:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267110AbTAFRSX>; Mon, 6 Jan 2003 12:18:23 -0500
Received: from thanatos.clara.net ([195.8.69.60]:13068 "EHLO
	thanatos.clara.net") by vger.kernel.org with ESMTP
	id <S267078AbTAFRSW>; Mon, 6 Jan 2003 12:18:22 -0500
Date: Mon, 6 Jan 2003 17:26:48 +0000
From: Faye Pearson <faye@clara.net>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: Andrew Morton <akpm@digeo.com>, "Grover, Andrew" <andrew.grover@intel.com>,
       Pavel Machek <pavel@ucw.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] acpi_os_queue_for_execution()
Message-ID: <20030106172648.GA1743@clara.net>
References: <F760B14C9561B941B89469F59BA3A84725A107@orsmsx401.jf.intel.com> <3E196C17.7D318CAF@digeo.com> <20150000.1041857884@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150000.1041857884@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.18 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew McGregor [andrew@indranet.co.nz] wrote:
> So *that* is why ACPI kernels are so slow on my laptop (Dell i8k), and make 
> so much heat.  I bet one of those threads ends up busy looping because of 
> other brokenness.

My laptop was a lot happier when I removed the GPE _L00 method from my
DSDT which was busylooping sending a processor 0x80 event.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

Familiarity breeds contempt -- and children.
		-- Mark Twain
