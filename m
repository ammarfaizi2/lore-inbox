Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbVFVIqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbVFVIqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbVFVInr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:43:47 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:42093 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262939AbVFVIj4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:39:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YrZt2nMwegdbv5Oc3E9f5Qqq/xGzaKfQ8Q220CRmsIsFQCHWnegnjzpqMcR/7myCmZWoy8ia3pGCSaEPUIBk2w0794fE5ig2o8R2OgdKZX/ifv2MnAN8i1CRJXIPiKdbQxDIqDpB3zddD2+GwkOBHHf75e5EJ8Woogu9u5EMQWg=
Message-ID: <2cd57c90050622013937d2c209@mail.gmail.com>
Date: Wed, 22 Jun 2005 16:39:53 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: lkml <linux-kernel@vger.kernel.org>
Subject: [question] pass CONFIG_FOO to CC problem
Cc: sam@ravnborg.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was expecting kbuild passes CONFIG_FOO from .config to CC
-DCONFIG_FOO, but it doesn't.  So I have to add

ifdef CONFIG_FOO
EXTRA_CFLAGS += -DCONFIG_FOO
endif

Is that the right way? thanks in advance.

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
