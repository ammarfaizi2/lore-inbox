Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288322AbSAHUzG>; Tue, 8 Jan 2002 15:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288323AbSAHUyu>; Tue, 8 Jan 2002 15:54:50 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:51342
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288322AbSAHUyS>; Tue, 8 Jan 2002 15:54:18 -0500
Message-Id: <200201082039.g08KdbA28865@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org, esr@thyrsus.com
Subject: Re: ISA slot detection on PCI systems?
Date: Tue, 8 Jan 2002 07:52:09 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0201042101400.20620-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0201042101400.20620-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 January 2002 03:09 pm, Dave Jones wrote:
> On Fri, 4 Jan 2002, Eric S. Raymond wrote:
> > X86 and ((not PCI) or (not DMI) or DMI_ISA or BLACKLISTED => ISA_CARDS
>
> You'd also need (not MCA) (not VLBUS) (not Other arcane non-ISA buses)

VLBUS is ISA.  It's a bag on the side of ISA.  You can stick an 8 or 16 bit 
ISA card into a VLBUS slot.

Rob
