Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbREaChg>; Wed, 30 May 2001 22:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262090AbREaChZ>; Wed, 30 May 2001 22:37:25 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:23377 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S261639AbREaChN>;
	Wed, 30 May 2001 22:37:13 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
cc: "'Martin Mares'" <pci-ids@ucw.cz>, "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.x: update for PCI vendor id 0x12d4 
In-Reply-To: Your message of "Wed, 30 May 2001 15:34:17 -0400."
             <6B1DF6EEBA51D31182F200902740436802678F04@mail-in.comverse-in.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 May 2001 12:36:39 +1000
Message-ID: <14652.991276599@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001 15:34:17 -0400, 
"Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com> wrote:
>BTW I noticed a funny thing: the file devlist.h I tried to 
>patch doesn't always exist - as it gets built from the file 
>pci.ids in the same directory. Noone complained on that :)

drivers/pci/ devlist.h, classlist.h and gen-devlist are the generated
files.  Add them to your "don't diff" list when generating patches.

>What I don't understand is why pci_ids.h doesn't get
>generated from pci.ids as well.

Leave that question for Martin.

