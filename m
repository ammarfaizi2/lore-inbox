Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUBHRW3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 12:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUBHRW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 12:22:28 -0500
Received: from [217.73.129.129] ([217.73.129.129]:41896 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263942AbUBHRW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 12:22:28 -0500
Date: Sun, 8 Feb 2004 19:22:11 +0200
Message-Id: <200402081722.i18HMBFT074505@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: 2.4.23 && md raid1 && reiserfs panic
To: linux-kernel@vger.kernel.org, james@rcpt.to
References: <20040207112302.GA2401@phobe.internal.pelicanmanufacturing.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bromberger <james@rcpt.to> wrote:

JB> The symptoms: rm a file from a working RAID1 md reiserfs filesystem, 
JB> and I get a panic, rm(1) segfaults, and all further I/O to any interactive 
JB> shells stop. The entire system is rednered incapable; reboot (via 
JB> ctrl-alt-del) doesnt shutdown and the only action is to hard reset the box.

What if you run reiserfsck over the volume that seems to be corrupted,
then fix the errors and then retry the operation?

Bye,
    Oleg
