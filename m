Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131777AbRCXUCH>; Sat, 24 Mar 2001 15:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131778AbRCXUB5>; Sat, 24 Mar 2001 15:01:57 -0500
Received: from d83b5259.dsl.flashcom.net ([216.59.82.89]:45440 "EHLO
	home.lameter.com") by vger.kernel.org with ESMTP id <S131777AbRCXUBr>;
	Sat, 24 Mar 2001 15:01:47 -0500
Date: Sat, 24 Mar 2001 11:56:08 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
To: linux-kernel@vger.linux.org
Subject: ReiserFS phenomenon with 2.4.2 ac24/ac12
Message-ID: <Pine.LNX.4.21.0103241154150.2429-100000@home.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a directory /a/yy that I tried to erase with rm -rf /a/yy.

rm hangs...

ls gives the following output:

ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
ls: /a/yy/cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb: No such file
or directory
ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
ls: /a/yy/cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb: No such file
or directory

and so on and so on....

I tried a reiserfscheck -x on the /a volume but the strangeness still
persists. What is going on here?



