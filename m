Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263864AbUFKMKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUFKMKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 08:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUFKMKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 08:10:54 -0400
Received: from nepa.nlc.no ([195.159.31.6]:63660 "HELO nepa.nlc.no")
	by vger.kernel.org with SMTP id S263864AbUFKMKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 08:10:53 -0400
Message-ID: <1088.83.109.37.51.1086955845.squirrel@nepa.nlc.no>
Date: Fri, 11 Jun 2004 14:10:45 +0200 (CEST)
Subject: Re: timer + fpu stuff locks my console race
From: stian@nixia.no
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0-1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML seems to not be affected, but it produces Floating Point Exception and
kills the program. Better respons than what happens when running on the
host (x86).

Seems like the kernel is still alive, but doesn't want to context switch
in user-space programs any more and io-schedules also stops.


Stian Skjelstad
