Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTEDPfl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 11:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTEDPfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 11:35:41 -0400
Received: from dsl081-246-102.sfo1.dsl.speakeasy.net ([64.81.246.102]:52113
	"EHLO zork.zork.net") by vger.kernel.org with ESMTP id S263637AbTEDPfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 11:35:41 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
References: <Pine.LNX.4.33L2.0305041132530.17172-100000@rtlab.med.cornell.edu>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: AMPHIBOLY, STYLE OVER SUBSTANCE
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 04 May 2003 16:48:08 +0100
In-Reply-To: <Pine.LNX.4.33L2.0305041132530.17172-100000@rtlab.med.cornell.edu> (Calin
 A. Culianu's message of "Sun, 4 May 2003 11:40:35 -0400 (EDT)")
Message-ID: <6ubryiemrr.fsf@zork.zork.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Calin A. Culianu" <calin@ajvar.org> writes:

> On Sun, 4 May 2003, Ingo Molnar wrote:
>>
>> wrt. address-space randomization, "prelink -R" already provides quite good
>> randomization of the shared library addresses, which should give some
>> statistical protection against remote attacks, i dont think we'll need
>> kernel support for that.
>
> What is prelink -R?

       -R --random
              When assigning addresses to libraries, start with random
              address within architecture dependant virtual address
              space range.  This can make some buffer overflow attacks
              slightly harder to exploit, because libraries are not
              present on the same addresses accross different
              machines.  Normally, assigning virtual addresses starts
              at the bottom of architecture dependant range.

-- 
Sean Neakums - <sneakums@zork.net>
