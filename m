Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWDXTJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWDXTJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWDXTJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:09:44 -0400
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:5088 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1751131AbWDXTJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:09:44 -0400
Message-ID: <444D2268.1030802@free.fr>
Date: Mon, 24 Apr 2006 21:09:28 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: bttv 2.6.16: wrong VBI_OFFSET?
References: <20060424190200.653333fe.froese@gmx.de>
In-Reply-To: <20060424190200.653333fe.froese@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Edgar Toernig wrote:
> Hi,
> 
> in 2.6.16 the code in driver/media/video/bttv-vbi.c was changed
> a little bit.  Beside other things, the constant 244 for the vbi
> offset was replaced by a #define VBI_OFFSET 128.
> 
> Afaics, the old value 244 was correct - was the change to 128
> intentionally?

You can have some comments about that in the git log : 
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=67f1570a0659abba5efbf55cc986187af61bdd52;hp=7e57819169d4f9a1d7af55fb645ece3fb981e2e3


Matthieu
