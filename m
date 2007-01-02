Return-Path: <linux-kernel-owner+w=401wt.eu-S932908AbXABSFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908AbXABSFb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932907AbXABSFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:05:31 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:50194 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932910AbXABSFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:05:30 -0500
In-Reply-To: <1167494007.14081.75.camel@imap.mvista.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: Should be [PATCH -mm] --  Re: [PATCH -rt] panic on SLIM + selinux
X-Mailer: Lotus Notes Release 7.0.1P Oct 16, 2006
Message-ID: <OF9AB42A1E.A7654F8F-ON85257257.0061FF6C-85257257.00642493@us.ibm.com>
From: Mimi Zohar <zohar@us.ibm.com>
Date: Tue, 2 Jan 2007 13:05:27 -0500
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V80_M3_10312006|October 31, 2006) at
 01/02/2007 13:05:27,
	Serialize complete at 01/02/2007 13:05:27
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Being able to compile both SELinux and SLIM into the kernel was done
intentionally.  The kernel parameters 'selinux' and 'slim' can enable
or disable the LSM module at boot.  Perhaps, for the time being, the
SECURITY_SLIM_BOOTPARAM_VALUE should default to 0.

Mimi
