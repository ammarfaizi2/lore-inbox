Return-Path: <linux-kernel-owner+w=401wt.eu-S1760836AbWLKCsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760836AbWLKCsP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 21:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757935AbWLKCsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 21:48:15 -0500
Received: from ozlabs.org ([203.10.76.45]:40335 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760836AbWLKCsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 21:48:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17788.50849.140884.507248@cargo.ozlabs.ibm.com>
Date: Mon, 11 Dec 2006 13:46:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olivier Galibert <galibert@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jean Delvare <khali@linux-fr.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sysfs file creation result nightmare (WAS radeonfb: Fix sysfs_create_bin_file warnings)
In-Reply-To: <20061209223418.GA76069@dspnet.fr.eu.org>
References: <20061209165606.2f026a6c.khali@linux-fr.org>
	<1165694351.1103.133.camel@localhost.localdomain>
	<20061209123817.f0117ad6.akpm@osdl.org>
	<20061209214453.GA69320@dspnet.fr.eu.org>
	<20061209135829.86038f32.akpm@osdl.org>
	<20061209223418.GA76069@dspnet.fr.eu.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert writes:

> Hmmm, then why don't you just drop the return value from the creation
> function and BUG() in there is something went wrong.  That would allow
> for better error messages too.

In this instance, BUG would mean that the console text would not ever
show up on the screen, and thus the user would never see the message
nor get any indication what wrong beyond "it failed to boot".

Paul.
