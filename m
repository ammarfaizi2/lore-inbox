Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbUCYAPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbUCYAL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:11:57 -0500
Received: from palrel13.hp.com ([156.153.255.238]:58033 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263028AbUCYAL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:11:29 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16482.9133.536372.808784@napali.hpl.hp.com>
Date: Wed, 24 Mar 2004 16:11:25 -0800
To: trini@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, davidm@hpl.hp.com
Subject: Re: [patch 9/22] __early_param for ia64
In-Reply-To: <20040324235904.JMM2477.fed1mtao01.cox.net@localhost.localdomain>
References: <20040324235904.JMM2477.fed1mtao01.cox.net@localhost.localdomain>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 24 Mar 2004 18:59:04 -0500, trini@kernel.crashing.org said:

  trini> CC: davidm@hpl.hp.com - Remove saved_command_line (and saving
  trini> of the command line).  - Call parse_early_options - Convert
  trini> mem= to __early_param.

This part looks OK to me, except that you should also delete this line:

#define COMMAND_LINE_SIZE	512

from arch/ia64/kernel/setup.c.

Thanks,

	--david
