Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263070AbUK0ACE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbUK0ACE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUK0ABT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:01:19 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263069AbUKZTl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:41:27 -0500
Date: Thu, 25 Nov 2004 14:42:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Work around for periodic do_gettimeofday hang
In-Reply-To: <1101356864.4007.35.camel@mulgrave>
Message-ID: <Pine.LNX.4.53.0411251441400.31392@yvahk01.tjqt.qr>
References: <1101314988.1714.194.camel@mulgrave>  <1101323621.2811.24.camel@laptop.fenrus.org>
 <1101356864.4007.35.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, 2004-11-24 at 13:13, Arjan van de Ven wrote:
>> while I agree with 100Hz for slower cpus, I rather have a config option for it so people
>> (and distros) can select it independent of the exact cpu type they want to compile a kernel for
>
>How about this then?

I'd rather make it a number field rather than "choose-me", so the wise user can
choose any Hz he likes.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
