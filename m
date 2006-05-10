Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWEJKS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWEJKS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWEJKS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:18:26 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21193 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S964887AbWEJKSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:18:25 -0400
Message-ID: <4461B789.4030606@ums.usu.ru>
Date: Wed, 10 May 2006 15:51:05 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix console utf8 composing
References: <Pine.LNX.4.61.0604022005290.12603@yvahk01.tjqt.qr> <Pine.LNX.4.61.0605082211580.20743@yvahk01.tjqt.qr> <44604977.1090008@ums.usu.ru> <200605100131.02692.ioe-lkml@rameria.de> <Pine.LNX.4.61.0605100904250.27657@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605100904250.27657@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.34.1.29; VDF: 6.34.1.59; host: usu2.usu.ru)
X-AV-Checked: ClamAV using ClamSMTP@relay4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> Just for the archive...
>>
>> On Tuesday, 9. May 2006 09:49, Alexander E. Patrakov wrote:
>>> Both the current situation and my patch share the defect that an accent 
>>> cannot be put on top of a multibyte character, such as Greek letter alpha.
> 
> With 80x25, that [almost] would not be possible either because of the 256 
> character limit. Of course the concern is totally valid for fbterm.

This concern is totally valid for the 80x25 console and the standard "gr" keymap:

compose '\'' 'α' to 'ά'

and the ά character is indeed present in the iso07.16 font and used in *.po 
files from console-tools.

-- 
Alexander E. Patrakov
