Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272731AbTHEMwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272734AbTHEMwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:52:11 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:9663 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S272731AbTHEMwF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:52:05 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Interactive Usage of 2.6.0.test1 worse than 2.4.21
Date: Tue, 5 Aug 2003 14:52:02 +0200
User-Agent: KMail/1.5.3
References: <200308050704.22684.martin.konold@erfrakon.de>
In-Reply-To: <200308050704.22684.martin.konold@erfrakon.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308051452.02417.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 August 2003 07:04, Martin Konold wrote:
> Hi,
>
> when using  2.6.0.test1 on a high end laptop (P-IV 2.2 GHz, 1GB RAM) I
> notice very significant slowdown in interactive usage compared to 2.4.21.
>
> The difference is most easily seen when switching folders in kmail. While
> 2.4.21 is instantaneous 2.6.0.test1 shows the clock for about 2-3 seconds.
>
> I am using maildir folders on reiserfs.
>
> Can anyone verify this behaviour?
>

Yes, I can definitely verify this, its not only related to kde/kmail, all 
other application are affected as well. Btw, I already upgraded to 
2.6.0-test2. 
Also, the slowdown seems to be related to hd-accessing/caching. My root-fs hd 
makes rather loud noises on accessing it -- with 2.6.0-testX the frequency of 
disk-accessing and so also the noise-level has dramatically increased 
compared to 2.4.x


So following the advices, I will try bk4 and mm4 and also will do the 

>CPU profiles, e.g.
>readprofile -n -m /boot/System.map-`uname -r` | sort -rn -k 1,1 | head -25
>Also logs of vmstat 1.

stuff.


Regards,	
	Bernd

-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
