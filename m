Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUJHIOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUJHIOr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 04:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUJHIOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 04:14:47 -0400
Received: from village.ehouse.ru ([193.111.92.18]:48649 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S269796AbUJHIKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 04:10:14 -0400
From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
To: comsatcat@earthlink.net
Subject: Re: Megaraid random loss of luns
Date: Fri, 8 Oct 2004 11:47:38 +0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <1096586111.25603.13.camel@solaris.skunkware.org>
In-Reply-To: <1096586111.25603.13.camel@solaris.skunkware.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410081147.39035.rathamahata@ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 October 2004 03:15, comsatcat wrote:
> I'm not sure if this is the correct list or not to ask about this, but
> it seemed proper.  We have a machine running the megaraid module that
> came with vanilla 2.6.7.  Earlier this morning all the luns suddenly
> disappeared for no apparent reason.
> 
> The kernel logged the following messages:
<cut>
> Could someone provide an explanation of what exactly went wrong if
> possible (if the megaraid driver was at fault or the raid controller)? 
> Are there any known bugs with large raid 5 volumes using the megaraid
> driver?  The volumes are each 325G (4 total) in this situation.  We've
> experienced other problems with the megaraid driver such as 1TB luns
> (two per controller) loosing almost all disks in them (I thought this
> was a controller problem at first, but we have 2 different models of
> controllers, 1 LSI PCI 320-4x and 2 LSI PCI 320-2x's, on 3 identical
> hardware configurations and have been experiencing problems on all of
> them).
I've got exactly the same issues for four of my machines under heavy IO load
(all are raid1) with megaraid 320-{1,2} and megaraid 160 (Series 475).
kernel 2.6.8.1. For me it looks like a driver issue rather than  a particular
controller problem ...

-- 
Sergey S. Kostyliov <rathamahata@ehouse.ru>
Jabber ID: rathamahata@jabber.org
