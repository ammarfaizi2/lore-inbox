Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbTDJOHy (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 10:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbTDJOHy (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 10:07:54 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:37350 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id S264044AbTDJOHx (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 10:07:53 -0400
Subject: Re: gcc-2.95 broken on PPC?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mikpe@csd.uu.se
Cc: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
In-Reply-To: <200304101256.h3ACuSw3022796@harpo.it.uu.se>
References: <200304101256.h3ACuSw3022796@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049984455.555.83.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Apr 2003 16:20:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 14:56, mikpe@csd.uu.se wrote:

> However, bugs #1 (zlib.c) and #3 (div64.h) disappear if I compile
> my kernels with gcc-3.2.2 instead of 2.95.4, which is a strong
> indication that 2.95.4 is broken on PPC. Is this something that's
> well-known to PPC people?
> 
> The patches are included below for reference.

It would be interesting to see the section dumps of the resulting
coff image and compare the version that works and the one that
doesn't. I still suspect some alignement crap, seeing this may
eventually show it.

Ben.

