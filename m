Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbUKCILA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbUKCILA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 03:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUKCILA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 03:11:00 -0500
Received: from mail3.speakeasy.net ([216.254.0.203]:15524 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S261454AbUKCIKt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 03:10:49 -0500
Date: Wed, 3 Nov 2004 00:10:46 -0800 (PST)
From: vlobanov <vlobanov@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: EXPORT_SYMBOL_NOVERS question
Message-ID: <Pine.LNX.4.58.0411030007220.22814@shell2.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was looking over the /include/linux/module.h file, and the
EXPORT_SYMBOL_NOVERS macro caught my eye. To quote the source:

  /* We don't mangle the actual symbol anymore, so no need for
   * special casing EXPORT_SYMBOL_NOVERS.  FIXME: Deprecated */
  #define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)

A quick grep through the tree brought up no usage cases for this macro.
Is there any reason to keep it around, instead of cutting it out, as the
FIXME comment seems to suggest?

-Vadim Lobanov
