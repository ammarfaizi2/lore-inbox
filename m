Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWC2AN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWC2AN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWC2AN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:13:26 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:57541 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964866AbWC2AN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:13:26 -0500
Message-ID: <4429D11F.6040000@garzik.org>
Date: Tue, 28 Mar 2006 19:13:19 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
CC: "Theodore Ts'o" <tytso@mit.edu>,
       "Jeff V. Merkey" <jmerkey@soleranetworks.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: e2label suggestions
References: <4429AF42.1090101@soleranetworks.com> <20060328232927.GB32385@thunk.org> <4429D3E4.3060305@wolfmountaingroup.com>
In-Reply-To: <4429D3E4.3060305@wolfmountaingroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.4 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.4 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> the detection of and translation of
> LABEL=/ is passed in the kernel, so its a kernel issue.

Incorrect.  The kernel does zero 'LABEL=' processing.  Read 
init/do_mount*.c.

LABEL= is handled in initrd/initramfs normally.

	Jeff


