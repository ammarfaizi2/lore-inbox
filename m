Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262904AbVAKVxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbVAKVxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVAKVpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:45:11 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:30735 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262896AbVAKVof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:44:35 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Ilias Biris <xyz.biris@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: User space out of memory approach
Date: Tue, 11 Jan 2005 23:35:50 +0200
User-Agent: KMail/1.5.4
References: <3f250c71050110134337c08ef0@mail.gmail.com> <1105461106.16168.41.camel@localhost.localdomain> <4e1a70d1050111111614670f32@mail.gmail.com>
In-Reply-To: <4e1a70d1050111111614670f32@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501112335.51017.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 January 2005 21:16, Ilias Biris wrote:
> Hi
> 
> where I come from we say (jokingly of course) 'got a headache? chop
> your own head ... end of problem'.
> 
> Though your system is not guaranteed to become more stable. When you
> forbid overcommitting memory, all you do is make failure occur for ALL
> processes at a different time. A process is happily doing something
> useful when all of a sudden its fork may die due to 'out of memory'

Application which does not check fork, malloc, etc for
success is buggy.
--
vda

