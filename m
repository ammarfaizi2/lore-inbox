Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267736AbSLTFzS>; Fri, 20 Dec 2002 00:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267738AbSLTFzS>; Fri, 20 Dec 2002 00:55:18 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:28381 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S267736AbSLTFzQ>; Fri, 20 Dec 2002 00:55:16 -0500
Message-ID: <3E02B263.4000801@snapgear.com>
Date: Fri, 20 Dec 2002 16:02:11 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: pcibios functions left in m68knommu port
References: <20021217172107.GA21714@kroah.com> <3DFFC5EA.6010201@snapgear.com> <20021219174236.GE6380@kroah.com>
In-Reply-To: <20021219174236.GE6380@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Greg KH wrote:
> Great, here's a patch against 2.5.52 that removes the unneeded
> functions.  I think you might be able to remove a few of the static
> variables in this file now too, but I don't want to break anything, as I
> don't have a machine to test this on.
> 
> Hm, I think I have a uCsimm around here somewhere...

You could on that, but it doesn't have a PCI bus, so you
couldn't really test with that. The only 2 boards I know
of that this supports are the Motorola M5407C3 and the
Moreton Bay eLIA.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

