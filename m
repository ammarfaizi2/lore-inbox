Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbSJWNfS>; Wed, 23 Oct 2002 09:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264991AbSJWNfS>; Wed, 23 Oct 2002 09:35:18 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:30469 "EHLO
	prosun.first.gmd.de") by vger.kernel.org with ESMTP
	id <S264990AbSJWNfR>; Wed, 23 Oct 2002 09:35:17 -0400
Subject: slowdown after suspend to disk on 2.4.{9,10,17-current} kernels.
From: Soeren Sonnenburg <sonnenburg@informatik.hu-berlin.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 23 Oct 2002 15:41:26 +0200
Message-Id: <1035380486.25072.19.camel@calculon>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I have a samsung NV5000 notebook here. After I put the notebook into the
suspend to disk mode and then turn it on again it runs very very slow
(My test method for now was the logout button in gdm. When that is
clicked the screen is filled with a 01010101 pattern. It takes like 8
seconds after a suspend to disk and <1s before).

I tried several kernels: 2.4.{9,10,17,18,19,20-pre11) without success.
I turned off any powermanagement in the bios and tried all the
combinations of BIOS vs ACPI/APM/OFF without any change. I tried to apm
-s , ALLOW_INTERRUPTS, ... without success.

Since I heard of buggy gcc variants included in redhat I compiled the
20-pre11 kernel using gcc2.95 on a different machine. Also I tried
setting to i386 up to PIII .... still same behaviour.

Then I booted a standard Redhat 7.2 (IIRC) 2.4.9-34 kernel,which worked
as expected (no slowdown, however other issues which I hoped were fixed
in the meantime). Also compiling that one with the options I used for
the above tests makes the notebook work.

It looks like there is no newer bios on samsungs web-page. I don't know
how I can find the real cause

Thanks for any ideas,
Soeren.

