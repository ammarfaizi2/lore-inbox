Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265229AbUFMRvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUFMRvg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 13:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUFMRvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 13:51:36 -0400
Received: from p213.54.74.240.tisdip.tiscali.de ([213.54.74.240]:46210 "EHLO
	stralsunder-10.homelinux.org") by vger.kernel.org with ESMTP
	id S265229AbUFMRve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 13:51:34 -0400
Date: Sun, 13 Jun 2004 19:51:34 +0200
From: Andreas Schmidt <andy@space.wh1.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Frequent system freezes after kernel bug
Message-ID: <20040613175134.GO1733@rocket>
References: <20040612183742.GE1733@rocket> <20040612202023.GA22145@taniwha.stupidest.org> <20040612214947.GI1733@rocket> <40CB9B84.4030502@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <40CB9B84.4030502@g-house.de> (from evil@g-house.de on Sun, Jun 13, 2004 at 02:10:44 +0200)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.06.13 02:10, Christian Kujau wrote:
> Andreas Schmidt wrote:
> |> On Sat, Jun 12, 2004 at 08:37:42PM +0200, Andreas Schmidt wrote:
> |>
> |> > > kernel: EIP:    0010:[iput+44/592]    Tainted: P
> |>
> | fcdsl                 862816   2
> 
> could be totally unrelated, but please try to reproduce without this
> (tainted) fcdsl module. it is often known for weird lockups. i'm not
> able to tell from the oops message, so i have to ask: is this an SMP  
> box?
The box has just one processor (Duron, in case it's relevant). BTW, I'm  
a bit at a loss how to reproduce the problem. Trouble is, it appears  
quite arbitrarily. The box has been running about 26hrs now without a  
reboot. (OK, there wasn't much activity today except handling mails.) I  
could unload the fcdsl module, which would cut me off the net. If  
necessary, I could even do this for a day or two -- but what if that  
error didn't occur during that time? As I'm not sure what triggered it  
in the first place, IMHO nothing could be deduced with certainty from  
the error not occuring. There'd only be definite information if it  
_did_ happen again. So, what do you suggest? (Sorry if that sounds  
obnoxious, but I'm really a bit confused about this stuff...)


Best regards,

Andreas


