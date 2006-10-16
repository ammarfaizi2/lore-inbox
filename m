Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161038AbWJPU05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWJPU05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWJPU05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:26:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:14329 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161038AbWJPU04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:26:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=S8ELAiyrutyGLgWlO22xcTFgvGS4BD9TPsZ0IBvnfOmzUfy1PihGGfnBq1f4kgTkFep1Ze4S5ZiQyCEPkzwj/FfkJDd0kouPTo0UcAEC0ZiOXTNgp6AdTyjxNZ82efUcnz5LQO+633k9LNMduHYj9Q98Zb3vXlfm/cZG94oc18w=
Date: Mon, 16 Oct 2006 15:26:45 -0500
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Subject: Re: copy_from_user / copy_to_user with no swap space
From: mfbaustx <mfbaustx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
References: <op.thi3x1mvnwjy9v@titan> <B72905BB-6E8D-47FD-9A20-269B27136DB2@mac.com>
Content-Transfer-Encoding: 7bit
Message-ID: <op.thi62vj9nwjy9v@titan>
In-Reply-To: <B72905BB-6E8D-47FD-9A20-269B27136DB2@mac.com>
User-Agent: Opera Mail/9.01 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pages and memory-mapped files may be "swapped-out" even *without* a swap  
> device.  As an example, when I first start /bin/bash (ignoring readahead

Fair enough.  The kernel can reclaim pieces of RAM knowing that certain  
text sections will availble on the storage medium from which they were  
originally loaded.  Right?

Also, I suppose one of the less obvious side-effects of using copy_to_user  
would be to cause a copy-on-write of a data section?

