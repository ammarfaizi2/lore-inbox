Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267720AbTBUWE5>; Fri, 21 Feb 2003 17:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267735AbTBUWE5>; Fri, 21 Feb 2003 17:04:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50954 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267720AbTBUWE4>;
	Fri, 21 Feb 2003 17:04:56 -0500
Date: Fri, 21 Feb 2003 22:15:03 +0000
From: Matthew Wilcox <willy@debian.org>
To: Bjorn Helgaas <bjorn_helgaas@hp.com>
Cc: "Moore, Robert" <robert.moore@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Walz, Michael" <michael.walz@intel.com>, t-kochi@bq.jp.nec.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
Message-ID: <20030221221503.F19234@parcelfarce.linux.theplanet.co.uk>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAFC@orsmsx107.jf.intel.com> <200302211509.15641.bjorn_helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302211509.15641.bjorn_helgaas@hp.com>; from bjorn_helgaas@hp.com on Fri, Feb 21, 2003 at 03:09:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 03:09:15PM -0700, Bjorn Helgaas wrote:
> Or, since you mention a macro, maybe your question is not about
> the usefulness of acpi_resource_to_address64() itself, but about
> how I implemented it, namely, with the copy_field and copy_address
> macros:

Can I suggest that you do a simple memcpy() for the case where you're
translating an address64 into an address64?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
