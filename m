Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290716AbSAYUGr>; Fri, 25 Jan 2002 15:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290735AbSAYUGh>; Fri, 25 Jan 2002 15:06:37 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:10371 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S290716AbSAYUGU>;
	Fri, 25 Jan 2002 15:06:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Date: Fri, 25 Jan 2002 12:05:55 -0800
X-Mailer: KMail [version 1.3.8]
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Therien, Guy" <guy.therien@intel.com>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        "'lwn@lwn.net'" <lwn@lwn.net>,
        "Acpi-linux (E-mail)" <acpi-devel@lists.sourceforge.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de> <200201250802.32508.bodnar42@phalynx.dhs.org> <jeelkes8y5.fsf@sykes.suse.de>
In-Reply-To: <jeelkes8y5.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200201251205.55440.bodnar42@phalynx.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 25, 2002 08:15, Andreas Schwab wrote:
> These are all startup costs that are lost in the noise the longer the
> program runs.

Executable size is -not- just a startup cost. Larger executables will have a 
bigger memory footprint and less cache locality. A KDE desktop on 64megs of 
memory would be noticably more responsive if GCC generated executables the 
same size as VC++, due to less swap thrashing alone.

-Ryan
