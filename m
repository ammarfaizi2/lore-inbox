Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVC1RlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVC1RlT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVC1RlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:41:19 -0500
Received: from fep16.inet.fi ([194.251.242.241]:54145 "EHLO fep16.inet.fi")
	by vger.kernel.org with ESMTP id S261966AbVC1RlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:41:16 -0500
Subject: [PATCH 0/9] isofs: unobfuscate rock.c
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ie2p3m.2u2ccu.3z4p19m1j53m9pob6l5ceeebq.refire@cs.helsinki.fi>
Date: Mon, 28 Mar 2005 20:41:15 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes macro obfuscation from fs/isofs/rock.c and cleans it up
a bit to make it more readable and maintainable. There are no functional
changes, only cleanups. I have only tested this lightly but it passes
mount and read on small Rock Ridge enabled ISO image.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
