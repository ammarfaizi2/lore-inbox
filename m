Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbTDFRe6 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 13:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbTDFRe6 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 13:34:58 -0400
Received: from AMarseille-201-1-5-206.abo.wanadoo.fr ([217.128.250.206]:64807
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263038AbTDFRe6 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 13:34:58 -0400
Subject: Re: [PATCH] New radeonfb fork
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030406170137.F0DB726AC@dreamland.darkstar.lan>
References: <20030406170137.F0DB726AC@dreamland.darkstar.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049651440.553.50.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 06 Apr 2003 19:50:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-06 at 19:01, Kronos wrote:
> Nell'articolo <20030406153018$1b2f@gated-at.bofh.it> hai scritto:
> > Note that I also bring
> > in various other pci_ids.h updates but that shouldn't harm
> > you and is easier that way for me ;)
>
> Hi Ben,
> your patch breaks ide-pci.c. PCI_DEVICE_ID_CMD_680 and
> PCI_DEVICE_ID_PDC_1841 aren't defined any more. This patch fixes the
> compilation:

Ah, sorry, I updated pci_ids.h to 2.4.21 level along with the patch,
that must be the cause.

I'll update the patch tomorrow, I lack time today though, except if
you can send me a patch against the patch (just revert the entries
in pci_ids.h then).

Ben.

