Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTKXWB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTKXWB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:01:56 -0500
Received: from aneto.able.es ([212.97.163.22]:11177 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261305AbTKXWBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:01:54 -0500
Date: Mon, 24 Nov 2003 23:01:46 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc4
Message-ID: <20031124220146.GA1823@werewolf.able.es>
References: <Pine.LNX.4.44.0311241656430.8709-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0311241656430.8709-100000@logos.cnet> (from marcelo.tosatti@cyclades.com on Mon, Nov 24, 2003 at 19:58:06 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.24, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> Here goes -rc4, fixing modular IDE breakage present in 2.4.23 kernels.
> 

Hey, you posted rc4 before I could talk about rc3... ;)
Good and bad news. Good are that pci=noacpi works. Bad are that
ACPI still fails to setup PCI bus 1 on a ServerWorks LE.
I think this is not a showstopper, but...
Relevant info is at

http://giga.cps.unizar.es/~magallon/linux/acpi/

dmesg for -rc3 without acpi, just what CONFIG_SMP uses, with acpi, and with
acpi but booted with pci=noacpi (all with lspci at the end), and output
from dmidecode, biosdecode and acpidmp.

I have also submited an entry in bugzilla.
For my blind eyes, it looks like an IRQ routing problem.

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.4.23-rc3-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
