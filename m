Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264568AbUANTns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbUANTmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:42:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:43496 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264471AbUANTll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:41:41 -0500
User-Agent: Microsoft-Entourage/10.1.1.2418
Date: Wed, 14 Jan 2004 20:40:33 +0100
Subject: Hude read/write cache
From: J=?ISO-8859-1?B?/A==?=rgen Scholz <juergen@scholz-gmbh.cc>
To: <linux-kernel@vger.kernel.org>
Message-ID: <BC2B59C1.2E87%juergen@scholz-gmbh.cc>
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Content-transfer-encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:150d20c68877055ca0efd2f4e3b0e0d9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I got a small server, which main purpose is routing and dialup besides being
a repository for files. This system is very noisy. Because of that I want to
stop the disks from spinning, when the system is in regular usage (standby,
routing..). This should happen through a read and write cache which keeps
the most often used files in RAM (like log files, bash, ...), so that there
is no need for the system to access the (physical) hard drive.
I would like to use a regular filesystem with a sort of transparent cache.
Any ideas?

Ciao,
Jürgen

