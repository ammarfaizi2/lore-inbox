Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293245AbSCKHNj>; Mon, 11 Mar 2002 02:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSCKHN3>; Mon, 11 Mar 2002 02:13:29 -0500
Received: from gateway2.ensim.com ([65.164.64.250]:59919 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S293245AbSCKHNR>; Mon, 11 Mar 2002 02:13:17 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Hanna V Linder <hannal@us.ibm.com>
cc: Paul Menage <pmenage@ensim.com>, viro@math.psu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6 Fast Walk Dcache (improved) 
In-Reply-To: Your message of "Sun, 10 Mar 2002 11:51:53 PST."
             <3031260852.1015761112@[10.10.2.2]> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Mar 2002 23:13:07 -0800
Message-Id: <E16kJzX-0005CN-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>	There seems to be a problem while booting with this patch applied
>on an 8-way SMP (.config available). Here is where the boot process stops:

I tested the SMP kernel (default config), but only on a UP box. Do you
get that problem on smaller systems, or just the 8-way box?

>Setting clock  (localtime): Sun Mar 10 11:10:27 PST 2002 [  OK  ]
>Loading default keymap (us): [  OK  ]
>

I guess that doing swapon is the next step. But you'd think that if it 
was going to die during swapon, the display would read

Activating swap partitions:

rather than nothing after the keymap line.

Paul

