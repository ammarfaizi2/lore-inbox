Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWCBSoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWCBSoh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWCBSog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:44:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64159 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751660AbWCBSof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:44:35 -0500
Date: Thu, 2 Mar 2006 13:44:28 -0500
From: Dave Jones <davej@redhat.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Message-ID: <20060302184428.GB7304@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ashok Raj <ashok.raj@intel.com>, "Brown, Len" <len.brown@intel.com>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
References: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com> <20060302083038.A11407@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302083038.A11407@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 08:30:38AM -0800, Ashok Raj wrote:


 > Could you see what comes out of the /proc/acpi/processor/CPUx/info for all the
 > 3 listed in your system?

I thought I already posted that..

(13:43:44:davej@nemesis:~)$ cat /proc/acpi/processor/CPU*/info
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        no
throttling control:      yes
limit interface:         yes
processor id:            1
acpi id:                 2
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no
processor id:            255
acpi id:                 3
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no


 > Also if you can send DSDT dump just to look over.

http://people.redhat.com/davej/dsdt

		Dave

