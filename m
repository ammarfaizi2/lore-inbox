Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264985AbTFLUg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbTFLUg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:36:29 -0400
Received: from palrel13.hp.com ([156.153.255.238]:11186 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264985AbTFLUg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:36:28 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16104.59268.744899.840326@napali.hpl.hp.com>
Date: Thu, 12 Jun 2003 13:50:12 -0700
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [PATCH] early_port_register
In-Reply-To: <20030612132001.A4693@home.com>
References: <20030612132001.A4693@home.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 12 Jun 2003 13:20:01 -0700, Matt Porter <mporter@kernel.crashing.org> said:

  Matt> Linus, please apply.
  Matt> This has been discussed in a previous thread originated by David
  Matt> Mosberger.  This removed early_serial_setup() in favor of  a
  Matt> working early_port_register() call.  Many PPC systems rely on
  Matt> this functionality and are currently hacking around it in the
  Matt> PPC devel tree.  Last I looked, IA64 still had this in their
  Matt> devel tree too.

Absolutely.  I was planning to resubmit it, but you beat me to it (and
I'm happy you did; one less thing to worry about... ;-).

	--david
