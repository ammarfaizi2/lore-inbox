Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbTGLTta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 15:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267852AbTGLTta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 15:49:30 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:55560 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266134AbTGLTt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 15:49:29 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.5.75+ - what fs is expected (allowed) to use in passed nameidata?
Date: Sat, 12 Jul 2003 23:35:13 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307122335.13971.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any rules what fs methods are allowed to access in passed nameidata? 
Specifically, is it valid to access nd->dentry and/or nd->mnt? Or is it just 
to pass flags information?

TIA

-andrey
