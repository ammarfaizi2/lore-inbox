Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbSLRAlr>; Tue, 17 Dec 2002 19:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbSLRAlr>; Tue, 17 Dec 2002 19:41:47 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:8676 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S267041AbSLRAlq>; Tue, 17 Dec 2002 19:41:46 -0500
Message-ID: <3DFFC5EA.6010201@snapgear.com>
Date: Wed, 18 Dec 2002 10:48:42 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: pcibios functions left in m68knommu port
References: <20021217172107.GA21714@kroah.com>
In-Reply-To: <20021217172107.GA21714@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Greg KH wrote:
> I just noticed the arch/m68knommu/kernel/comempci.c file, which contains
> a lot of pcibios functions that are now removed from the rest of the
> kernel.  Are these present for any specific reason, or would you be
> willing to take a patch removing them?

Happy to take a patch.
Most of that baggage has been carried through since that support
was first coded (circa linux-2.0.38).

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

