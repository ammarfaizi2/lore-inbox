Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbTCaCU1>; Sun, 30 Mar 2003 21:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbTCaCU1>; Sun, 30 Mar 2003 21:20:27 -0500
Received: from main.gmane.org ([80.91.224.249]:14052 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261367AbTCaCU0>;
	Sun, 30 Mar 2003 21:20:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: John Goerzen <jgoerzen@complete.org>
Subject: Re: Kernel compile error with 2.5.66
Date: Sun, 30 Mar 2003 20:30:30 -0600
Organization: Complete.Org
Message-ID: <873cl4fet5.fsf@complete.org>
References: <87brztwwaa.fsf@complete.org> <B76E0B36-624D-11D7-9043-00039346F142@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@complete.org
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2
Cancel-Lock: sha1:2Rb9+G2vIl8ET7kvfFXzQ4zRqdY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stewart Smith <stewartsmith@mac.com> writes:

> Yeap, I'm getting this too. There seems to be a whole bunch of changes
> in include/asm-ppc64/pgtable.h that aren't in
> include/asm-ppc/pgtable.h

I should say that after my post, I tried out the linuxppc-2.5 2.5.66
tree at http://www.penguinppc.org/dev/kernel.shtml, and it did not
have this problem.

However, I could not get it to compile for numerous other reasons:

 * If PnP BIOS is enabled, it fails to compile the x86 assembler.

 * All Modules fail to load due to some sort of missing symbol (sorry, I
   didn't take notes) Q_MODULE or something maybe.

 * A non-module-enabled kernel fails to build, complaining of a
   missing isa_virt_to_bus symbol.  And that happened even after I
   enabled the unnecessary ISA support.

 * hdparm causes a kernel oops and apparent lockup (again, I didn't
   take notes, I was just trying to make the darn thing boot)

In short, 2.5 on PowerPC does not seem to be in a very good state
right now.

-- John

