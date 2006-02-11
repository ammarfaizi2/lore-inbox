Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWBKX0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWBKX0z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 18:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWBKX0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 18:26:55 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:29774 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750827AbWBKX0y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 18:26:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ya0nC42Ryp2MYEDdTUZ2fWsfDaVpOngMn3c73l77hfbIWxOWZw7I1ws6lb1SgOLj0lFPoSSt7msw/aNk+iPGZLiRnZUdUXKk8IZ4jUamSCtaxcVdjeY82qjOXhdLOEdQescKUvgIfG0y12etv+osoq22prDDYK/Ak07I9kvMMkE=
Message-ID: <bda6d13a0602111526y6f0d3382v9e9d8143f5b85966@mail.gmail.com>
Date: Sat, 11 Feb 2006 15:26:53 -0800
From: Joshua Hudson <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I feel like putting my two cents in.

Suppose you just made 4K stacks the default. Since users of
ndiswrapper already have to recompile the kernel, making one
configuration change as well can't be that hard, especially since
ndiswrapper checks kernel options when compiling.
