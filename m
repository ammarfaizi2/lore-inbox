Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285065AbSADWQF>; Fri, 4 Jan 2002 17:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285062AbSADWPp>; Fri, 4 Jan 2002 17:15:45 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:34998 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S285060AbSADWPe>; Fri, 4 Jan 2002 17:15:34 -0500
Date: Fri, 4 Jan 2002 22:17:29 +0000
From: Dave Jones <davej@suse.de>
To: knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
Message-ID: <20020104221729.A5688@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, knobi@knobisoft.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C3592E0.38DFA96A@sirius-cafe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3592E0.38DFA96A@sirius-cafe.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 12:32:48PM +0100, Martin Knoblauch wrote:
 >  seeing this thread - is there any serious work being spend on something
 > like "hinv" on IRIX, which gives you a *complete* listing of your
 > hardware? I have seen some attempts at shell and perl scripts, but none
 > of them really is trustworthy.

 When devicefs is ready (or more to the point, the drivers become
 devicefs aware), something to the effect of ls -R /devices 
 should be possible.

 If we have ACPI fill out the tree, it enumerates pretty much
 every device you have in the system, and half dozen you probably
 didn't know you had.

Dave.

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
