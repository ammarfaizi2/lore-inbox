Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbTJaXCL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 18:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTJaXCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 18:02:11 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:24810 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S263711AbTJaXCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 18:02:09 -0500
To: Dave Jones <davej@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Post-halloween doc updates.
From: Junio C Hamano <junkio@cox.net>
References: <20031030141519.GA10700@redhat.com>
Date: Fri, 31 Oct 2003 15:02:07 -0800
Message-ID: <7vllr1xb80.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you add the following to the Regressions section?

- In 2.4 users of Japanese keyboards were able to type '|' or
  '\' characters without loading any custom keymap on the
  console.  With the keymap in 2.6, this is not possible
  anymore.  People with these keyboards have to load a keymap
  with loadkeys rebuilt from the source, since loadkeys in some
  vendor distributions cannot load keycodes larger than 127.
  There is a patch to fix this, but it has not been integrated
  (http://tinyurl.com/t75a).

