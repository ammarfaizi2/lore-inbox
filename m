Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbTDRJYw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 05:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbTDRJYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 05:24:52 -0400
Received: from hera.cwi.nl ([192.16.191.8]:52469 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262977AbTDRJYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 05:24:51 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 18 Apr 2003 11:36:46 +0200 (MEST)
Message-Id: <UTC200304180936.h3I9aki10287.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH] struct loop_info
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can we name it old_dev_t or dev16_t ?

Not 16 - the size varies among architectures.
Yes, nothing wrong with __old_dev_t.

Andries
