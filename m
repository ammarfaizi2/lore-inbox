Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTIQUpJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbTIQUpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:45:09 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:21141 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262649AbTIQUpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:45:07 -0400
Date: Wed, 17 Sep 2003 21:44:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Ben Johnson <ben@blarg.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linear vs. logical addresses?  how does cpu interpret kernel addrs?
Message-ID: <20030917204457.GB3252@mail.jlokier.co.uk>
References: <20030916154747.A22526@blarg.net> <Pine.LNX.4.53.0309170734240.881@chaos> <20030917124221.A3970@blarg.net> <Pine.LNX.4.53.0309171551080.426@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309171551080.426@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Note also that there are two seldom- used segment registers, FS and GS.

GS is used for thread-local storage in userspace now, since NPTL
became the standard Linux threading library.

-- Jamie
