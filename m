Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbVCDNLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVCDNLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVCDNEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:04:46 -0500
Received: from [81.2.110.250] ([81.2.110.250]:51163 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262877AbVCDNBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 08:01:38 -0500
Subject: Re: [2.6 patch] unexport uts_sem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304005001.GA4608@stusta.de>
References: <20050304005001.GA4608@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109941076.29932.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Mar 2005 12:57:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-04 at 00:50, Adrian Bunk wrote:
> I didn't find any possible modular usage in the kernel.

Sure ? This used to be exported for loadable modules that wanted to get
the system default hostname string and for emulation layers like xabi
(the SYS5 unix emulation lib)

Alan

