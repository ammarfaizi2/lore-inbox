Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268594AbUJDVue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268594AbUJDVue (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268663AbUJDVsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:48:38 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:25058 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268594AbUJDVrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:47:47 -0400
Date: Mon, 04 Oct 2004 14:48:33 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org, greg@kroah.com
Subject: Re: [PATCH 2.6] pci-hplj.c: replace pci_find_device with pci_get_device
Message-ID: <290370000.1096926512@w-hlinder.beaverton.ibm.com>
In-Reply-To: <20041004214107.GA2160@linux-mips.org>
References: <281940000.1096925207@w-hlinder.beaverton.ibm.com> <20041004214107.GA2160@linux-mips.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, October 04, 2004 11:41:07 PM +0200 Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Oct 04, 2004 at 02:26:47PM -0700, Hanna Linder wrote:
>> If  someone has access to an RM200 or RM300 and could test this I would appreciate it.
> 
> Except that piece of code isn't for an RM[23]00 but a HP Laserjet (yes,
> that paper eating thing ;-) and hasn't seen any update or feedback from
> the original submitters since the original submission, so the entire HPLJ
> code is a candidate for removal ...
> 
>    Ralf

Ahh thanks, the comments at the top of the file confused me:

 * SNI specific PCI support for RM200/RM300.

I have no opinion on the codes deletion or not. I'm simply changing all
occurances of pci_find_device. Hopefully people will not confuse that
work with my having any familiarity with the actual devices themselves :)

Thanks a lot.

Hanna


