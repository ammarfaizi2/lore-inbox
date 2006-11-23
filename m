Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757100AbWKWL7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757100AbWKWL7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757175AbWKWL7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:59:53 -0500
Received: from mail.parknet.jp ([210.171.160.80]:32776 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1757100AbWKWL7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:59:52 -0500
X-AuthUser: hirofumi@parknet.jp
To: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       The Peach <smartart@tiscali.it>, linux-kernel@vger.kernel.org
Subject: Re: [OT] bug? VFAT copy problem
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
	<1164204175.10427.1.camel@localhost.localdomain>
	<20061122145344.GB18141@DervishD> <1164243385.3525.19.camel@monteirov>
	<20061123091301.GC21908@DervishD> <87hcwq1jg7.fsf@duaron.myhome.or.jp>
	<45658B19.8010207@mandic.com.br>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 Nov 2006 20:59:41 +0900
In-Reply-To: <45658B19.8010207@mandic.com.br> (Renato S. Yamane's message of "Thu\, 23 Nov 2006 09\:50\:49 -0200")
Message-ID: <87ac2i1ihe.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Renato S. Yamane" <renatoyamane@mandic.com.br> writes:

> OGAWA Hirofumi escreveu:
>> Right. FAT's size field is 32bit, so *file* of FAT has limit of 4GB-1.
>> (Since directory doesn't have size, in theoretically it can exceed 4GB-1)
>> 
>> Hm.. Maybe MS added a new hack to FAT..?
>
> Ogawa, MS don't added a new hack to FAT32... This file system don't
> support file size with more than 4Gb:
> <http://msdn2.microsoft.com/en-us/library/aa365678.aspx>

Thanks. Yes. However, Sergio's windows seems to handle file size more
than 4GB-1...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
