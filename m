Return-Path: <linux-kernel-owner+w=401wt.eu-S1751369AbXAKS24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbXAKS24 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 13:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbXAKS2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 13:28:55 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:49297 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbXAKS2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 13:28:55 -0500
Message-ID: <45A681E5.6060502@s5r6.in-berlin.de>
Date: Thu, 11 Jan 2007 19:28:53 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Akula2 <akula2.shark@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.20-rc4 - Kernel panic!
References: <8355959a0701110300j33d28f54y67728eb847c7ba31@mail.gmail.com>
In-Reply-To: <8355959a0701110300j33d28f54y67728eb847c7ba31@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akula2 wrote:
> mount: could not find file system  '/dev/root'

Make sure that the bootloader is correctly configured and that all
drivers which are necessary to access the root filesystem are inserted
(statically linked, or loaded from an initrd).
-- 
Stefan Richter
-=====-=-=== ---= -=-==
http://arcgraph.de/sr/
