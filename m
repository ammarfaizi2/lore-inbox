Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbUKWU3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbUKWU3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbUKWU1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:27:46 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:33039 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261471AbUKWUY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:24:57 -0500
To: Colin Leroy <colin@colino.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
References: <20041118194959.3f1a3c8e.colin@colino.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 24 Nov 2004 05:24:36 +0900
In-Reply-To: <20041118194959.3f1a3c8e.colin@colino.net> (Colin Leroy's
 message of "Thu, 18 Nov 2004 19:49:59 +0100")
Message-ID: <87653wxqij.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Leroy <colin@colino.net> writes:

> It adds MS_SYNCHRONOUS support to FAT filesystem, so that less
> filesystem breakage happen when disconnecting an USB key, for 
> example. I'd like to have comments about it, because as it 
> seems to work fine here, I'm not used to fs drivers and could
> have made mistakes.

What cases should these patches guarantee that users can unplug the
USB key?  And can we guarantee the same cases by improving autofs or
the similar stuff?

I'm not sure sync-mode is proper for it...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
