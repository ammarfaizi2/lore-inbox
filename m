Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbTLVIyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 03:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbTLVIyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 03:54:05 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:50358 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264365AbTLVIyD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 03:54:03 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16358.45353.786574.288849@laputa.namesys.com>
Date: Mon, 22 Dec 2003 11:54:01 +0300
To: "Per Jessen" <per@computer.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: make menuconfig loops ??
In-Reply-To: <20031221144427.57D00DAA81@mail.local.net>
References: <20031221144427.57D00DAA81@mail.local.net>
X-Mailer: VM 7.17 under 21.5 (patch 16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per Jessen writes:
 > Hi,
 >   
 > I have a problem when trying to build a kernel. It appears that make menuconfig
 > starts to loop - 
 > after writing "Preparing scripts: functions, parsing ...done."
 > This is 2.4.23, jfs114, gcc3.3.2.

I have seen this when file system with kernel sources was mounted
noexec. What is in /proc/mounts?

Nikita.

 >   
