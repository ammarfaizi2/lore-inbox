Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264276AbUFUPRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbUFUPRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 11:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266261AbUFUPRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 11:17:09 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:1152 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S264276AbUFUPRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 11:17:00 -0400
Date: Mon, 21 Jun 2004 17:17:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-bk way too fast
Message-ID: <20040621151738.GA1351@ucw.cz>
References: <xb7r7s9nj2c.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb7r7s9nj2c.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 03:20:59PM +0200, Sau Dan Lee wrote:

>     Vojtech> It's possible that X does it's own autorepeat, though
>     Vojtech> that'd rather surprise me.
> 
> Why?  XFree86 has been doing its own autorepeat, I think.
> 
>         $ xset q
>         Keyboard Control:
>           auto repeat:  on    key click percent:  0    LED mask:  00000000
>           auto repeat delay:  660    repeat rate:  25
>           auto repeating keys:  00ffffffdffffbbf
>                                 fa9fffffffdfe5ff
>                                 ffffffffffffffff
>                                 ffffffffffffffff
>           bell percent:  50    bell pitch:  400    bell duration:  100
> 
> And I  can change it via "xset  r rate [delay [rate  ]]", according to
> "xset help".  Indeed,  you can use 'xset' to  change the rate/delay to
> very  extreme values,  which  exceed the  hardware  allowed on  AT/PS2
> keyboards (e.g. rates > 30  cps), adjusted with the 'kbdrate' command.
> So, the only  possibility for these hardware limits  to be transcended
> is s/w based autorepeat.
 
Indeed, X does its own autorepeat.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
