Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268541AbUHLMxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268541AbUHLMxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268531AbUHLMvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:51:40 -0400
Received: from styx.suse.cz ([82.119.242.94]:57218 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S268543AbUHLMtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:49:07 -0400
Date: Thu, 12 Aug 2004 14:50:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jakub Vana <gugux@centrum.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86 - Realmode BIOS and Code calling module
Message-ID: <20040812125059.GA2923@ucw.cz>
References: <20040812093653Z2097836-29040+39160@mail.centrum.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812093653Z2097836-29040+39160@mail.centrum.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 11:36:40AM +0200, Jakub Vana wrote:
> Hello,
> 
> I have written Linux Kernel module that allows you to call BIOS interupts, Far services or your own code. It's working on x86 machines with PAE or not PAE enabled(up to 4GB or up to 64GB). It's tested on 2.4.26 and 2.6.7 kernel on P4 machine. I think there is not problem to work on others. Now, I'm preparing DOCs and Demos.
> 
> I wrote the module especialy for changing the VESAFB videomode, but It is usable anywhere the BIOS is neaded.
> 
> I'm writing you to know this code exists and to ask you for help to add this code to official Kernel distribution.
 
Can't this be done from userspace without kernel support? I think X
already does exactly that to initialize secondary VGA cards, and to set
videomodes on intel VGA's.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
