Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291689AbSBHSDg>; Fri, 8 Feb 2002 13:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291690AbSBHSDZ>; Fri, 8 Feb 2002 13:03:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30225 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291689AbSBHSDJ>; Fri, 8 Feb 2002 13:03:09 -0500
Subject: Re: [patch] larger kernel stack (8k->16k) per task
To: arjanv@redhat.com
Date: Fri, 8 Feb 2002 18:16:23 +0000 (GMT)
Cc: tigran@veritas.com (Tigran Aivazian), linux-kernel@vger.kernel.org
In-Reply-To: <3C640994.F3528E74@redhat.com> from "Arjan van de Ven" at Feb 08, 2002 05:23:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZFZQ-0004St-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, there's also a simple script you can run on the vmlinux to catch
> big offenders....
> I can even see the point of running that at the end of "make bzImage"
> and abort or
> at least seriously warn if there are offenders that, say, allocate more
> than 2Kb of stackspace.

Thats worth doing too if its reliable
