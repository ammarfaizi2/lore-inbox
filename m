Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262572AbSJBUfo>; Wed, 2 Oct 2002 16:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262573AbSJBUfo>; Wed, 2 Oct 2002 16:35:44 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:26643 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262572AbSJBUfn>; Wed, 2 Oct 2002 16:35:43 -0400
Message-Id: <200210022035.g92KZkp31963@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: DervishD <raul@pleyades.net>, undertow <undertow@dexcom.org>
Subject: Re: possible bug
Date: Wed, 2 Oct 2002 23:29:40 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <1033487088.2369.6.camel@aenima> <20021001163743.GA275@DervishD>
In-Reply-To: <20021001163743.GA275@DervishD>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 October 2002 14:37, DervishD wrote:
>     I'm spanish, too ;)) But let's go to the matter: probably the PID
> you're trying to 'kill -9' is stuck in 'D' state (or any other
> uninterruptible state), so it's not a kernel bug ;) If this is not

How come? Process stuck in 'D' state *is* a kernel bug
(well, the only legitimate reason for it is a hard,nointr NFS mount
and remote server down but I still think that this mount option for NFS
should be never used).
--
vda
