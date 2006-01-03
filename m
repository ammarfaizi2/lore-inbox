Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWACMKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWACMKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 07:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWACMKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 07:10:04 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:23852 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1751378AbWACMKD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 07:10:03 -0500
From: =?iso-8859-1?q?Jo=E3o_Esteves?= <joao.m.esteves@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: Via VT 6410 Raid Controller
Date: Tue, 3 Jan 2006 12:10:01 +0000
User-Agent: KMail/1.8.2
References: <200601021253.10738.joao.m.esteves@netcabo.pt> <200601031055.02257.joao.m.esteves@netcabo.pt> <58cb370e0601030340jbad02f0m6073dae957384c9b@mail.gmail.com>
In-Reply-To: <58cb370e0601030340jbad02f0m6073dae957384c9b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601031210.01594.joao.m.esteves@netcabo.pt>
X-OriginalArrivalTime: 03 Jan 2006 12:10:02.0380 (UTC) FILETIME=[9FFD84C0:01C6105E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

> You don't seem to have VIA IDE driver compiled in et all.
>
> Could you retry with Daniel's patch applied and "VIA82CXXX chipset
> support" (CONFIG_BLK_DEV_VIA82CXXX config option) compiled-in?
> Yes, help entry should be updated. :-)

I believe this option is inserted after "make xconfig", when "qconf" window 
appears. Sorry for this, it is my first time compiling the kernel. Perhaps it 
is not bad ideia to say what I'm doing:

In /usr/src/linux:

 1. Ataching the patch: 
# cat /root/via6410.patch | patch -p1
(I renamed the patch file to via6410.patch)

2.# make xconfig

3. # make 
    # sudo modules_install install

4. Reboot.

All this went with no error messages and the system reboots OK, with the new 
kernel in the Lillo boot options.

Regards and thanks for your help.

João
