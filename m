Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTESJEA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 05:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTESJD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 05:03:59 -0400
Received: from web11802.mail.yahoo.com ([216.136.172.156]:159 "HELO
	web11802.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261785AbTESJD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 05:03:59 -0400
Message-ID: <20030519091656.55599.qmail@web11802.mail.yahoo.com>
Date: Mon, 19 May 2003 11:16:56 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Whatever the processor, you cannot use write combining MTRR
 on 16 colors / 4 BPP modes. In this mode you can copy
 8 pixels at a time by doing a simple movb, but it cannot
 handle 32 pixel copy at the same time by a movd, for instance.
 In 16 color modes, you never have a linear memory mapping
 of pixels.

  Etienne.

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
