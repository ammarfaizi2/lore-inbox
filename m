Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWHXIo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWHXIo1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 04:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWHXIo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 04:44:27 -0400
Received: from web25802.mail.ukl.yahoo.com ([217.12.10.187]:29868 "HELO
	web25802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750900AbWHXIo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 04:44:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type;
  b=PCX1tyBkJR94bVDsqnDAVMI93SyxX4gx0w1jvoUfY/NUnelEfKVejPafriMVTTePUOQx9kRvdC9InDyAQA27YZurKWFBTZabXhKcF5AoIFqH4oFMtXgD2Wqqs9hrFhP4Y/JfV8wSFxsvMs+u4Za6++tsWEj8J6j2dWxjlp/0WaU=  ;
Message-ID: <20060824084425.83538.qmail@web25802.mail.ukl.yahoo.com>
Date: Thu, 24 Aug 2006 08:44:25 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: [HELP] Power management for embedded system
To: linux-pm@lists.osdl.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently working on a small embedded system based on a MIPS
processor. So far Linux works fine on it and I'd like to implement
power management on this system. For now I realize that APM and ACPI
are implemented by the kernel.

I don't think that ACPI is really suited for what I need. So I took a
look to APM implemetation which seems to be only implemented on i386,
arm and mips architectures. All of these implementations seem to be
based on i386 one. Mips one seems to be a copy and paste of arm one
and both of them have removed all APM bios stuff orginally part of
i386 implementation. It doesn't seem that APM is something really
stable and finished. So now I do not know from where to start...

Is there some other effort in the power management for _embedded_
systems ? I'd like to help in this area and it would be helpful to
know of certain projects that are working in this direction.

thanks

Francis


