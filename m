Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274034AbRJKIyM>; Thu, 11 Oct 2001 04:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274133AbRJKIyB>; Thu, 11 Oct 2001 04:54:01 -0400
Received: from trantor.dso.org.sg ([192.190.204.1]:24533 "EHLO
	trantor.dso.org.sg") by vger.kernel.org with ESMTP
	id <S274034AbRJKIx4>; Thu, 11 Oct 2001 04:53:56 -0400
Date: Thu, 11 Oct 2001 16:56:36 +0800
From: Richard Shih-Ping Chan <cshihpin@dso.org.sg>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Chan <cshihpin@dso.org.sg>, linux-kernel@vger.kernel.org
Subject: Re: -ac10,-ac11 no boot on SMP PentiumII box
Message-ID: <20011011165636.B1174@cshihpin.dso.org.sg>
In-Reply-To: <20011011110327.B25934@cshihpin.dso.org.sg> <E15rZx5-0002H4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15rZx5-0002H4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 11, 2001 at 08:08:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've narrowed it down to the change between 2.4.10-ac8 and 
-ac9. Maybe it has something to do with CONFIG_X86_PPRO_FENCE?


On Thu, Oct 11, 2001 at 08:08:19AM +0100, Alan Cox wrote:
> > Normally I would expect "Calibrating delay loop..." but no go.
> > 
> > Last -ac kernel tried was 2.4.9-ac10 with success.
> > 2.4.10 stock also works.
> > 
> > Has anything affected the CPU startup code?
> 
> Not that I am aware of. There are some locking changes in specific cases
> but I tested that still booted on my dual PPro
> 
> Alan

-- 
Richard Chan <cshihpin@dso.org.sg>
DSO National Laboratories
20 Science Park Drive
Singapore 118230
Tel: 7727045
Fax: 7766476
