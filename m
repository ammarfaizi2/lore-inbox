Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312691AbSCVGM3>; Fri, 22 Mar 2002 01:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312690AbSCVGMK>; Fri, 22 Mar 2002 01:12:10 -0500
Received: from theirongiant.weebeastie.net ([203.62.148.50]:27286 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S312689AbSCVGMF>; Fri, 22 Mar 2002 01:12:05 -0500
Date: Fri, 22 Mar 2002 17:11:16 +1100
From: CaT <cat@zip.com.au>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Stephen Williams <mrsteve@midsouth.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.19pre3-ac5
Message-ID: <20020322061116.GO880@zip.com.au>
In-Reply-To: <1016734453.1017.11.camel@swilliam.home.net> <Pine.LNX.4.10.10203212115360.4958-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 09:23:36PM -0800, Andre Hedrick wrote:
> It is a BUG() check to see if there are cases where the interrupt handler
> is being set (re armed) while it is currently set for another event.
> 
> if (HWGROUP(drive)->handler != NULL)
>      BUG();
> ide_set_handler(drive, handler, timeout, expirey);
> 
> If we are reloading the handler but it was set but something else , never
> called during a completion, and/or is dangling.  It is a typo my bad :-(
> 
> Edit and change it from "==" to "!="

Now I'm confused. Should that be != to ==? :) And every instance I find?

-- 
SOCCER PLAYER IN GENITAL-BITING SCANDAL  ---  "It was something between
friends that I thought would have no importance until this morning when
I got up and saw all  the commotion in the news,"  Gallardo told a news
conference. "It stunned me."
Reyes told Marca that he had "felt a slight pinch."
      -- http://www.azcentral.com/offbeat/articles/1129soccer29-ON.html
