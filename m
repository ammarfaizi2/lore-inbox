Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbRCBObz>; Fri, 2 Mar 2001 09:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbRCBObg>; Fri, 2 Mar 2001 09:31:36 -0500
Received: from jalon.able.es ([212.97.163.2]:61325 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129216AbRCBObb>;
	Fri, 2 Mar 2001 09:31:31 -0500
Date: Fri, 2 Mar 2001 15:31:17 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] style-curiosity
Message-ID: <20010302153117.A2690@werewolf.able.es>
In-Reply-To: <20010302120712.C4416@werewolf.able.es> <Pine.LNX.4.21.0103021223160.1338-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0103021223160.1338-100000@penguin.homenet>; from tigran@veritas.com on Fri, Mar 02, 2001 at 13:24:20 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.02 Tigran Aivazian wrote:
> On Fri, 2 Mar 2001, J . A . Magallon wrote:
> > for (c = misc_list.next; c != &misc_list; c = c->next)
> > {
> > 	if (c->minor == misc->minor) {
> > 		up(&misc_sem);
> > 		return -EBUSY;
> > 	}	
> > }
> 
> the above is good but the below is better:
> 
> for (c = misc_list.next; c != &misc_list; c = c->next)
>        if (c->minor == misc->minor) {
>                up(&misc_sem);
>                return -EBUSY;
>        }
>

I have suffered so many bugs coming from bad grouping that I always put
the braces even if they are not needed.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac8 #2 SMP Fri Mar 2 12:12:45 CET 2001 i686

