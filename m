Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTDWQEb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbTDWQEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:04:31 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:40127 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264097AbTDWQE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:04:29 -0400
Date: Wed, 23 Apr 2003 09:18:08 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Greg KH <greg@kroah.com>
cc: Hanna Linder <hannal@us.ibm.com>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org, andmike@us.ibm.com
Subject: Re: [RFC] Device class rework [0/5]
Message-ID: <41570000.1051114688@w-hlinder>
In-Reply-To: <20030423015454.GA6298@kroah.com>
References: <20030422205545.GA4701@kroah.com> <172940000.1051059583@w-hlinder> <20030423015454.GA6298@kroah.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, April 22, 2003 06:54:54 PM -0700 Greg KH <greg@kroah.com> wrote:

>> I did a quick sanity test of these patches on a 2-way PIII.
>> It built and booted fine for me. I don't have any devices that 
>> span multiple classes but the patch hasnt changed any of my 
>> existing /sys/class output.
> 
> Hm, are you sure you applied them and are using that kernel?  :)
> 

Yes. I did apply the patches... Just not to the kernel I booted ;(

Here is the correct tree I see on my 2xPIII:


/sys/class
|-- cpu
|   |-- cpu0
|   |   `-- device -> ../../../devices/sys/cpu0
|   `-- cpu1
|       `-- device -> ../../../devices/sys/cpu1
|-- input
|-- scsi-host
`-- tty
    |-- console0
    |   `-- dev
    |-- ptmx0
    |   `-- dev
    |-- pty0
    |   `-- dev
    |-- pty1
    |   `-- dev
    |-- pty10
    |   `-- dev
    |-- pty100
    |   `-- dev
    |-- pty101
    |   `-- dev
    |-- pty102
    |   `-- dev
    |-- pty103
    |   `-- dev
    |-- pty104
    |   `-- dev
    |-- pty105
    |   `-- dev
    |-- pty106
    |   `-- dev
    |-- pty107
    |   `-- dev
    |-- pty108
    |   `-- dev


