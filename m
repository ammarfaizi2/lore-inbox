Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUGLP4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUGLP4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 11:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266882AbUGLP4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 11:56:53 -0400
Received: from tristate.vision.ee ([194.204.30.144]:44473 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S266879AbUGLP4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 11:56:49 -0400
Message-ID: <40F2B4C6.5010307@vision.ee>
Date: Mon, 12 Jul 2004 18:56:54 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
Organization: Vision
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040705)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc1 -ck snapshot
References: <40F2A9C9.2040107@kolivas.org>
In-Reply-To: <40F2A9C9.2040107@kolivas.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Con Kolivas wrote:

> I've posted a snapshot of the current -ck development against 2.6.8-rc1

Just compiled it, found one minor problem (2.6.8-rc1-ck5+reiserfs4)
which was fixed like this (maybe reiserfs4 patch is the offender):

--- include/linux/fs.h.bak    2004-07-12 18:54:37 +0300
+++ include/linux/fs.h        2004-07-12 18:54:44 +0300
@@ -847,8 +847,6 @@

 extern struct sysfs_ops fs_attr_ops;

-};
-
 /*
  * Snapshotting support.
  */


Now gonna boot it...

Lenar

