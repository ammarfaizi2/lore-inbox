Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUA2Wvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 17:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUA2Wvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 17:51:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53771 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S266481AbUA2Wtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 17:49:40 -0500
Message-ID: <40198DE0.307@zytor.com>
Date: Thu, 29 Jan 2004 14:49:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Frodo Looijaard <frodol@dds.nl>
CC: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org,
       linux-7110-psion@lists.sourceforge.net
Subject: Re: PATCH to access old-style FAT fs
References: <20040126173949.GA788@frodo.local> <bv3qb3$4lh$1@terminus.zytor.com> <87n0898sah.fsf@devron.myhome.or.jp> <4016B316.4060304@zytor.com> <87ad4987ti.fsf@devron.myhome.or.jp> <20040128115655.GA696@arda.frodo.local> <87y8rr7s5b.fsf@devron.myhome.or.jp> <20040128202443.GA9246@frodo.local> <87bron7ppd.fsf@devron.myhome.or.jp> <20040129223944.GA673@frodo.local>
In-Reply-To: <20040129223944.GA673@frodo.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frodo Looijaard wrote:
> Hi,
> 
> I have attached a newer, better behaving version of my patch:
>   * Implements new mount option oldfat for FAT-derived filesystems.
>   * Stops scanning dirs when DIR_Name[0] = 0 when oldfat is set
>   * Writes a 0 to the next entry DIR_Name[0] when overwriting an entry
>     which has DIR_Name[0] = 0 when oldfat is set
> 

Please don't call this "oldfat".  There is nothing about this which is
"old-style"; it's a workaround for a bug in a specific OS.

	-hpa

