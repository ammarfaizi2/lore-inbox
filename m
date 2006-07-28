Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbWG1IWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWG1IWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWG1IWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:22:18 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:63759 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP id S932595AbWG1IWR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:22:17 -0400
To: "Brown, Len" <len.brown@intel.com>
Cc: "Shem Multinymous" <multinymous@gmail.com>, "Pavel Machek" <pavel@suse.cz>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>, <vojtech@suse.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       <linux-thinkpad@linux-thinkpad.org>, <linux-acpi@vger.kernel.org>
Subject: Re: Generic battery interface
References: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com>
From: Johan Vromans <jvromans@squirrel.nl>
Date: Fri, 28 Jul 2006 10:22:03 +0200
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com> (Len
 Brown's message of "Fri, 28 Jul 2006 00:05:35 -0400")
Message-ID: <m2k65ykul0.fsf@phoenix.squirrel.nl>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brown, Len" <len.brown@intel.com> writes:

> good for shell scripts, not clear it is better for C programs
> that have to open a bunch of files by name.

Moreover, it means that the factual data is only made available as a
nice textual string, that then has to be parsed by shell scripts and
other programs to get the factual data again.

So I feel much for /dev/xxx approach, together with the already
mentioned small utilities like 'batstat' for shell scripts.

-- Johan

