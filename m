Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVCFRDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVCFRDP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 12:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVCFRDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 12:03:15 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:37894 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261431AbVCFRDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 12:03:01 -0500
To: linux@MichaelGeng.de (Michael Geng)
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/29] FAT: Updated FAT attributes patch
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<20050306155329.GA1436@t-online.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 07 Mar 2005 02:02:41 +0900
In-Reply-To: <20050306155329.GA1436@t-online.de> (Michael Geng's message of
 "Sun, 6 Mar 2005 16:53:29 +0100")
Message-ID: <87wtskwvv2.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@MichaelGeng.de (Michael Geng) writes:

> On Sun, Mar 06, 2005 at 03:42:28AM +0900, OGAWA Hirofumi wrote:
>> +/* <linux/videotext.h> has used 0x72 ('r') in collision, so skip a few */
>
> These ioctls in videotext.h have been removed with 2.6.11. They were not used anywhere in the 
> kernel.

Thanks.  I think we still had better skip them, because the app such
as strace can handle it easily.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
