Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWJMVkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWJMVkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWJMVkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:40:31 -0400
Received: from web83103.mail.mud.yahoo.com ([216.252.101.32]:32383 "HELO
	web83103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030181AbWJMVka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:40:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=O8q3IhxdlZAnCxZyvEVkYQg/h/8Us2j0+rr0GGn3vNn+TO9YZBfN2SPW24RAUj/JzCMcmM46GOPxwK3HcjaA3A6Hv480NumEanryAkbs90KXmAKQr5ON9uO1ucjPY+C0rIN1kyeu1HF5A1Ht04LAkpRLJ8RGInKAvI61lPFAjaY=  ;
Message-ID: <20061013214029.35732.qmail@web83103.mail.mud.yahoo.com>
Date: Fri, 13 Oct 2006 14:40:29 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: RE: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
To: ryan@tau.solarneutrino.net, linux-kernel@vger.kernel.org,
       xhejtman@mail.muni.cz, auke-jan.h.kok@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Ryan Richter
>Sent: Friday, October 13, 2006 2:26 PM
>To: linux-kernel@vger.kernel.org
>Subject: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
>
>I have a new system based on the Inter 965G chipset, and all 
>the kernels
>I've used - 2.6.18, .19-rc1, and .19-rc2 - have failed to reset the
>machine on a reboot.  "Machine Restart" is printed, but it just hangs
>there.  SysRQ is non-functional at that point.

  The similar issue has been discussed in adjacent thread "Machine reboot". Is it Intel
motherboard, or just carries Intel chipset ? Does building e1000 driver as a module and 'rmmod
e1000' just before reboot help ?

Aleks.


