Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132468AbRDCTNg>; Tue, 3 Apr 2001 15:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132497AbRDCTN0>; Tue, 3 Apr 2001 15:13:26 -0400
Received: from jalon.able.es ([212.97.163.2]:21646 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132468AbRDCTNH>;
	Tue, 3 Apr 2001 15:13:07 -0400
Date: Tue, 3 Apr 2001 21:12:18 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Ben Ford <ben@kalifornia.com>
Cc: "J . A . Magallon" <jamagallon@able.es>, David Lang <dlang@diginsite.com>,
        linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
Message-ID: <20010403211218.A2387@werewolf.able.es>
In-Reply-To: <3AC91800.22D66B24@mandrakesoft.com> <Pine.LNX.4.33.0104021734400.30128-100000@dlang.diginsite.com> <20010403161322.A8174@werewolf.able.es> <3ACA1A91.70401@kalifornia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3ACA1A91.70401@kalifornia.com>; from ben@kalifornia.com on Tue, Apr 03, 2001 at 20:46:41 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.03 Ben Ford wrote:
> J . A . Magallon wrote:
> > 
> > If this has not been done for System.map, that is a much more important
> > info for debug and oops, and the de facto standard is to put it aside
> > kernel with some standadr naming, lets use the same method for config.
> > 
> That would be great and all, but can you tell me how to do it when I 
> have 3 or 4 different compiles of the same kernel version?
> 

Just like the Alan Cox for 2.4 or Andrea Arcangeli for 2.2. Lets say you
have 2.4.2-ac27. For each of your compiles, set EXTRAVERSION to -ac27-bf1,
-ac27-bf2, etc. Your files will be:
vmlinuz-2.4.2-ac27-bfX
System.map-2.4.2-ac27-bfX
config-2.4.2-ac27-bfX

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3 #2 SMP Fri Mar 30 15:42:05 CEST 2001 i686

