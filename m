Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271107AbTHLU62 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 16:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271120AbTHLU62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 16:58:28 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:43651 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S271107AbTHLU6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 16:58:23 -0400
Message-ID: <3F3954EB.1080406@gmx.net>
Date: Tue, 12 Aug 2003 22:58:19 +0200
From: Jens Leuschner <leuschner@gmx.net>
Organization: Chemnitz University of Technology, FRG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible fix for NFORCE2 IDE hangups
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -0.1 (/)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19mgDj-0002Dp-00*Vlw1FZUKf.M*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have an ASUS A7N8X Deluxe board and had those annoying hangups when 
the system had high disk activity.
I tried to reduce the UDMA level or even remove the amd74xx driver from 
my kernel and run the system with PIO, but the system still crashed from 
time to time.

Last weekend I disabled the use of the APIC (the system now uses XT-PIC) 
and this seems to fix the problem. The system ran stable with UDMA100 
enabled for the last 4 days.

HTH,
Jens


