Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVEKQll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVEKQll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 12:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVEKQlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 12:41:40 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:52135 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S261200AbVEKQli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 12:41:38 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
To: Miklos Szeredi <miklos@szeredi.hu>, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
Reply-To: 7eggert@gmx.de
Date: Wed, 11 May 2005 18:41:32 +0200
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> How about a new clone option "CLONE_NOSUID"?

IMO, the clone call ist the wrong place to create namespaces. It should be
deprecated by a mkdir/chdir-like interface.
-- 
Incoming fire has the right of way. 

