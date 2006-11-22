Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755276AbWKVQHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbWKVQHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755274AbWKVQHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:07:49 -0500
Received: from mail.parknet.jp ([210.171.160.80]:53511 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1755276AbWKVQHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:07:49 -0500
X-AuthUser: hirofumi@parknet.jp
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: The Peach <smartart@tiscali.it>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: bug? VFAT copy problem
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
	<1164204175.10427.1.camel@localhost.localdomain>
	<20061122145344.GB18141@DervishD>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 Nov 2006 01:07:32 +0900
In-Reply-To: <20061122145344.GB18141@DervishD> (DervishD's message of "Wed\, 22 Nov 2006 15\:53\:44 +0100")
Message-ID: <87ac2jv517.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <lkml@dervishd.net> writes:

>  * Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> dixit:
>> Have vfat a limit of a file size when copy ? 
>
>     2GB, if I recall correctly. FAT32 itself has a limit of 4GB-1 for
> file size, but Linux restricts it even more (don't ask me why).

It was fixed already, 2.6.x can handle 4GB-1.  2.4.x has limit of
2GB-1 (there is patch).
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
