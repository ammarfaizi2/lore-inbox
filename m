Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUFOImL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUFOImL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 04:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUFOImL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 04:42:11 -0400
Received: from elin.scali.no ([62.70.89.10]:62086 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S265287AbUFOImD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 04:42:03 -0400
Subject: Re: Does exec-shield with -fpie  work?
From: Terje Eggestad <terje.eggestad@scali.com>
To: arjanv@redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1087288401.2710.15.camel@laptop.fenrus.com>
References: <1087286723.3156.35.camel@pc-16.office.scali.no>
	 <1087288401.2710.15.camel@laptop.fenrus.com>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1087288917.3156.41.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Jun 2004 10:41:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Arjan

That did it!

TJ

On Tue, 2004-06-15 at 10:33, Arjan van de Ven wrote:
> > te pc-16 ~ 70> !gcc
> > gcc -fPIE -fpic -o ./testsc ./testsc.c
> > 
> 
> you need to pass -pie as option as well; -fpie for the compiler, -pie for the linker,
> eg
> 
> gcc -fPIE -pie -o ./testsc ./testsc.c
-- 

Terje Eggestad
Senior Software Engineer
dir. +47 22 62 89 61
mob. +47 975 31 57
fax. +47 22 62 89 51
terje.eggestad@scali.com

Scali - www.scali.com
High Performance Clustering

