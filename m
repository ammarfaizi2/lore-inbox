Return-Path: <linux-kernel-owner+w=401wt.eu-S1754909AbXABTCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbXABTCR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753672AbXABTCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:02:17 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:4089 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbXABTCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:02:16 -0500
Subject: Re: Should be [PATCH -mm] --  Re: [PATCH -rt] panic on SLIM +
	selinux
From: Daniel Walker <dwalker@mvista.com>
To: Mimi Zohar <zohar@us.ibm.com>
Cc: akpm@osdl.org, kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <OF9AB42A1E.A7654F8F-ON85257257.0061FF6C-85257257.00642493@us.ibm.com>
References: <OF9AB42A1E.A7654F8F-ON85257257.0061FF6C-85257257.00642493@us.ibm.com>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 11:01:19 -0800
Message-Id: <1167764480.26086.113.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 13:05 -0500, Mimi Zohar wrote:
> Being able to compile both SELinux and SLIM into the kernel was done
> intentionally.  The kernel parameters 'selinux' and 'slim' can enable
> or disable the LSM module at boot.  Perhaps, for the time being, the
> SECURITY_SLIM_BOOTPARAM_VALUE should default to 0.

They currently don't play nice together, i.e. the kernel panics with
both compiled in together and default settings. So something needs to
change..

Daniel

