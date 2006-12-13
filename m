Return-Path: <linux-kernel-owner+w=401wt.eu-S965095AbWLMTqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWLMTqX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWLMTqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:46:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36282 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965095AbWLMTqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:46:22 -0500
Subject: Re: Question: removal of syscall macros?
From: Arjan van de Ven <arjan@infradead.org>
To: Teunis Peters <teunis@wintersgift.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45804B99.2060008@wintersgift.com>
References: <45804B99.2060008@wintersgift.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 13 Dec 2006 20:46:19 +0100
Message-Id: <1166039179.27217.883.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 10:51 -0800, Teunis Peters wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Now that syscall macros have been pulled from the -mm tree, what method
> is recommended to use syscalls?
> 
> (I've wasted a day grubbing through sources before giving up and copying
> the old syscall macros into one key driver)
> 
> _syscall macros are used by:
> ATI driver  (no choice.  I'm working with laptops)

.. which uses it to call mprotect() from inside the driver. That's a
nice security hole right there... better ask ATI to fix it urgently :)


