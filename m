Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131665AbRCOMbj>; Thu, 15 Mar 2001 07:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131683AbRCOMba>; Thu, 15 Mar 2001 07:31:30 -0500
Received: from alpham.uni-mb.si ([164.8.1.101]:65297 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S131665AbRCOMbO>;
	Thu, 15 Mar 2001 07:31:14 -0500
Date: Thu, 15 Mar 2001 13:30:05 +0100
From: Igor Mozetic <igor.mozetic@uni-mb.si>
Subject: Re: 2.4.2 + aic7xxx still broken
In-Reply-To: <3A9E2993.9F78A9E8@redhat.com>
To: Doug Ledford <dledford@redhat.com>
Cc: linux-kernel@vger.kernel.org, pcg@goof.com
Message-id: <15024.46541.270976.912164@ravan.camtp.uni-mb.si>
MIME-version: 1.0
X-Mailer: VM 6.90 under Emacs 20.7.2
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
In-Reply-To: <15004.63506.871707.827656@ravan.camtp.uni-mb.si>
 <3A9D11E5.919104C3@redhat.com>
 <15006.9147.152358.314138@ravan.camtp.uni-mb.si> <3A9E2993.9F78A9E8@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford writes:

 > Either one should work.  Try it with the UP_IOAPIC support enabled and see if
 > that helps.  If it doesn't, then I would try Justin's driver and see if it
 > works.

Thanks, the machine now boots.
I'm using 2.4.3-pre3 + linux-aic7xxx-6.1.7 (UP on SMP board)
with the following APIC support enabled:

CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

-Igor Mozetic
