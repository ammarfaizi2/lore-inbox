Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTDURBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTDURBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:01:39 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:52619 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261743AbTDURBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:01:38 -0400
Subject: Re: [Bug 606] Hang occurs at reboot
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, gregkh@us.ibm.com
In-Reply-To: <26850000.1050939064@[10.10.2.4]>
References: <26850000.1050939064@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1050945208.1099.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 21 Apr 2003 19:13:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-21 at 17:31, Martin J. Bligh wrote:
> ------- Additional Comments From m4341@abc.se  2003-04-21 02:30 -------
> All three suggestions are tried, but I have located the problem to the ohci-hcd
> module, since I also get a hang when I trie to unload that module. This is
> currently only verified on the Vectra using the Kernel 2.5.68.

This has happened to me on my laptop since I started to test 2.5
kernels. The only solution I've found is to integrate uhci-hcd (and
ohci-hcd) into the kernel, instead of leaving it as a module.
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

