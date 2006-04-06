Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWDFRvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWDFRvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 13:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWDFRvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 13:51:50 -0400
Received: from mail.parknet.jp ([210.171.160.80]:65291 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751291AbWDFRvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 13:51:49 -0400
X-AuthUser: hirofumi@parknet.jp
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com
Subject: Re: [PATCH 2/2] writeback: fix range handling
References: <877j62n0l7.fsf@duaron.myhome.or.jp>
	<873bgqn0cs.fsf@duaron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 07 Apr 2006 02:51:42 +0900
In-Reply-To: <873bgqn0cs.fsf@duaron.myhome.or.jp> (OGAWA Hirofumi's message of "Fri, 07 Apr 2006 01:18:59 +0900")
Message-ID: <87d5fuk2xd.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> reiser4 doesn't check wbc->end, and perhaps it does not use cyclic
> behavior. So, I guess this is ok.
>
> Could you review this?

http://marc.theaimsgroup.com/?l=linux-kernel&m=114434015027282&w=2

This is why I changed it. Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
