Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVCMBUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVCMBUi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 20:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVCMBUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 20:20:38 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:46233 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261309AbVCMBUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 20:20:32 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH][RFC] Apply umask to /proc/<pid>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 13 Mar 2005 02:23:32 +0100
References: <fa.ft6scin.15lkbgv@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DAHpO-0001a8-Mx@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:

> patch below makes procfs apply the umask of the processes to their
> respective /proc/<pid> directories and the files below them.  That
> allows users to gain a bit of privacy by setting a restrictive umask in
> their profiles.

A [ur]limit-like value is fine, but allowing others to read the files you
put into a public directory should not imply giving up your privacy.

