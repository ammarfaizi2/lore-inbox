Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265995AbUFEDtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265995AbUFEDtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 23:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUFEDtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 23:49:03 -0400
Received: from palrel12.hp.com ([156.153.255.237]:30884 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264524AbUFEDs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 23:48:59 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16577.17064.857172.598873@napali.hpl.hp.com>
Date: Fri, 4 Jun 2004 20:48:56 -0700
To: Greg KH <greg@kroah.com>
Cc: davidm@hpl.hp.com, Michael_E_Brown@dell.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: EFI-support for SMBIOS driver
In-Reply-To: <20040605032902.GA7069@kroah.com>
References: <16577.6469.833064.763671@napali.hpl.hp.com>
	<20040605032902.GA7069@kroah.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 4 Jun 2004 20:29:02 -0700, Greg KH <greg@kroah.com> said:

  Greg> On Fri, Jun 04, 2004 at 05:52:21PM -0700, David Mosberger
  Greg> wrote:

  >> The patch below adds EFI support to the SMBIOS driver.

  Greg> The smbios driver is gone in 2.6.7-rc.  You don't need a
  Greg> driver for this, as you can do everything from userspace.

I know full well that it can be done in user-level --- via /dev/mem,
which lots of people dislike.  I certainly don't feel strongly about
it, but the SMBIOS driver made sense to me.

	--david
