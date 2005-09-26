Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVIZSqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVIZSqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVIZSqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:46:38 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:10209 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932472AbVIZSqh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:46:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=byRz5HiNOuz/an2blJU8ivIHxqLL4GhgWbBdWvPbPbRlx5gmG2oRvQNsOuw0N3xICRgGPpQpvBePn76lBjiVdPrU1xr/25nEVGb1h8aFEUZEimg47P6aY859ZNTO/YzI7xLCm60buhhaR4YeS87sA9oG8bIllHc6aUF/md4qePQ=
Message-ID: <cda58cb8050926114675524d59@mail.gmail.com>
Date: Mon, 26 Sep 2005 20:46:34 +0200
From: Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: questions on discontgmem.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to use discontigmem to access several RAM memories on an _no_
NUMA embedded system. In that case, does a node  mean a single RAM
whose start address is very different from the others ?

When CONFIG_NUMA is _not_ set, how is a node choosen during allocation
? any pointers are welcome !

With such mechanism, is it possible to create a block device (let say
/dev/my_ram) whose (meta) data belongs to a _single_ node ?

Thanks.
--
               Franck
