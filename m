Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129385AbQKVWtS>; Wed, 22 Nov 2000 17:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQKVWtI>; Wed, 22 Nov 2000 17:49:08 -0500
Received: from Cantor.suse.de ([194.112.123.193]:34065 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S129385AbQKVWs5>;
        Wed, 22 Nov 2000 17:48:57 -0500
Date: Wed, 22 Nov 2000 23:18:54 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): pci_device_id tables for linux-2.4.0-test11/drivers/block
Message-ID: <20001122231854.A29401@gruyere.muc.suse.de>
In-Reply-To: <200011222201.OAA29131@baldur.yggdrasil.com> <3A1C454E.FC4787CE@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A1C454E.FC4787CE@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Nov 22, 2000 at 05:14:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2000 at 05:14:38PM -0500, Jeff Garzik wrote:
> *This* is the over-engineering attitude I was talking about.  The only
> reason why you are preferring named initializers is because
> pci_device_id MIGHT be changed.  And if it is changed, it makes the
> changeover just tad easier.  For that, you ugly up the code and make it
> more difficult to maintain.

The other reason is that it makes self documenting code -- no need to look
up the structure definition to make sense out of the code.


-Andi (who thinks easily readable code is good) 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
