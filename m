Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbUK3PzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbUK3PzX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUK3PzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:55:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15757 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262120AbUK3PzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:55:18 -0500
Date: Tue, 30 Nov 2004 16:55:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Walking all the physical memory in an x86 system
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C2057CA887@azsmsx406>
Message-ID: <Pine.LNX.4.53.0411301654360.20450@yvahk01.tjqt.qr>
References: <C863B68032DED14E8EBA9F71EB8FE4C2057CA887@azsmsx406>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>	I've written a 2.4 kernel module where I'm trying to walk and
>record all of the physical memory contents in an x86 system. I have the
>following code fragment that does it but I suspect I'm missing a portion
>of the memory:
>
>Is there a better way to record all of the contents of physical memory
>since what I have above doesn't seem to get everything?

Maybe something userspace based?

dd_rescue /dev/mem copyofmem



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
