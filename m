Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314154AbSEBA5i>; Wed, 1 May 2002 20:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314200AbSEBA5h>; Wed, 1 May 2002 20:57:37 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:44815 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314154AbSEBA5h>; Wed, 1 May 2002 20:57:37 -0400
Message-Id: <200205011405.g41E5XX04713@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Scott A. Sibert" <kernel@hollins.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.11 and smbfs
Date: Wed, 1 May 2002 17:08:22 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3CCEF32B.6060807@hollins.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 April 2002 17:40, Scott A. Sibert wrote:
> I don't know if anyone's mentioned this (I tried searching through the
> recent list archives).  I have 2.5.11 compiled on a dual P3/800 with
> preempt enabled.  smbfs and 3c905c are compiled into the kernel (not
> modules).  It has 1gb memory and I have high memory (4gb) compiled.
>
> I can mount other samba shares fine (ie. Samba-2.2.2 from OSX 10.1.4 and
> Samba-2.2.2 from Tru64 5.1) and the directories look fine.  When I mount
> a share from a Windows 2000 server I only get the first letter of the
> entry in the shared folder which, of course, makes no sense and
> generates errors when just trying to get an "ls" of the share.  The
> Win2K servers are both regular server and Adv Server, both with SP2 and
> the latest patches.  The linux machine is running RedHat 7.2 with almost
> all of the latest updates and 2.5.11 compiled.

Let's try to isolate the cause. Does 2.4 kernel fail too?
--
vda
