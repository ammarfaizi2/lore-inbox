Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbTIQUfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTIQUfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:35:05 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:19861 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262640AbTIQUfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:35:03 -0400
Date: Wed, 17 Sep 2003 21:34:16 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Raf D'Halleweyn" <raf@noduck.net>,
       Vishwas Raman <vishwas@eternal-systems.com>, Valdis.Kletnieks@vt.edu,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Incremental update of TCP Checksum
Message-ID: <20030917203416.GA3252@mail.jlokier.co.uk>
References: <3F3C07E2.3000305@eternal-systems.com> <20030821134924.GJ7611@naboo> <3F675B68.8000109@eternal-systems.com> <200309161900.h8GJ0kYe019776@turing-police.cc.vt.edu> <3F67734A.8060804@eternal-systems.com> <1063769305.2801.1.camel@bigboy> <Pine.LNX.4.53.0309170911170.1161@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309170911170.1161@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> This is all wonderful. This assumes that the stuff being modified
> in the packet is on well-defined boundaries, seldom the case when
> you are re-writing packet data, but certainly the case if you
> are re-writing an IP address.

The only important boundary consideration is whether you're modifying
at an odd or even byte offset into the packet.

-- Jamie
