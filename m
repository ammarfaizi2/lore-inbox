Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbVHJWyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbVHJWyt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVHJWys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:54:48 -0400
Received: from dvhart.com ([64.146.134.43]:21122 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932585AbVHJWys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:54:48 -0400
Date: Wed, 10 Aug 2005 15:54:45 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: abonilla@linuxwireless.org,
       "'Jon Scottorn'" <jscottorn@possibilityforge.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Kernel panic 2.6.12.4
Message-ID: <1273120000.1123714485@flay>
In-Reply-To: <006701c59de5$146f0960$a20cc60a@amer.sykes.com>
References: <006701c59de5$146f0960$a20cc60a@amer.sykes.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, August 10, 2005 13:52:45 -0600 Alejandro Bonilla <abonilla@linuxwireless.org> wrote:

>> I am trying a custom 2.6.8 kernel now, and here is my
>> 2.6.12.4 .config file.
>> Let me know what you think.
> 
> I don't know much about Kernel Panics. I hope that someone that knows could
> take a look, but so far, it looks like you need to be running Sid to have
> this working propperly.
> 
> Please try 2.6.8, I'm almost sure that it should work.
> 
> And anyway, this ML is not really a user support list, try asking in a
> debian mailing list, if they think that it's something wrong with the
> kernel, then come back and let us know.

Kernel panics are fine, though you really need to give us the whole thing.
Make sure you run it through ksymoops, or have CONFIG_KKALLSYMS or whatever
it's called turned on.

adpt_isr is in drivers/scsi/dpt_i2o.c, so you have some SCSI driver
problem, I presume?

M.

