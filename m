Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbUCABsA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbUCABr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:47:59 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:12293 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262216AbUCABqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:46:53 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm1
Date: Mon, 1 Mar 2004 02:46:19 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040229140617.64645e80.akpm@osdl.org> <200403010239.11725@WOLK>
In-Reply-To: <200403010239.11725@WOLK>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rXpQAo+e/g4gMkg"
Message-Id: <200403010246.19629@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_rXpQAo+e/g4gMkg
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 01 March 2004 02:39, Marc-Christian Petersen wrote:

Hi Andrew,

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6
>.4-rc1-mm1/
> ext3-journalled-quotas.patch
>   ext3: Journalled quotas

kernel/fs/quota_v2.ko needs symbol 'mark_info_dirty'.

ciao, Marc

--Boundary-00=_rXpQAo+e/g4gMkg
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="2.6.4-rc1-mm1-fixups-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.4-rc1-mm1-fixups-2.patch"

--- old/fs/dquot.c	2004-02-29 23:38:42.000000000 +0100
+++ new/fs/dquot.c	2004-03-01 02:41:49.000000000 +0100
@@ -1672,3 +1672,4 @@ EXPORT_SYMBOL(unregister_quota_format);
 EXPORT_SYMBOL(dqstats);
 EXPORT_SYMBOL(dq_list_lock);
 EXPORT_SYMBOL(dq_data_lock);
+EXPORT_SYMBOL(mark_info_dirty);

--Boundary-00=_rXpQAo+e/g4gMkg--
