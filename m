Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbUDNDJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 23:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbUDNDJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 23:09:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:36266 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263762AbUDNDJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 23:09:07 -0400
Date: Tue, 13 Apr 2004 20:08:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josh Logan <josh@wcug.wwu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel hang on MX server
Message-Id: <20040413200849.5e6a5014.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404131648480.27502@sloth.wcug.wwu.edu>
References: <Pine.LNX.4.58.0404131648480.27502@sloth.wcug.wwu.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Logan <josh@wcug.wwu.edu> wrote:
>
> I have 2 IBM x305's which hang every few days in identical ways. 

Can you capture a sysrq-T trace?  Wait for a hang, do alt-sysrq-T?

Yo may need to arrange for klogd to write to a different disk, or
use a serial console.
