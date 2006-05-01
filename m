Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWEAXuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWEAXuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWEAXuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:50:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:41455 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932314AbWEAXuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:50:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Tue, 2 May 2006 01:49:54 +0200
User-Agent: KMail/1.9.1
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
References: <20060429232812.825714000@localhost.localdomain> <445690F7.5050605@am.sony.com> <FE7E70B5-F0CD-4254-8555-27EC2A70C316@kernel.crashing.org>
In-Reply-To: <FE7E70B5-F0CD-4254-8555-27EC2A70C316@kernel.crashing.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605020149.55310.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 01:09, Segher Boessenkool wrote:
> So it really should be
> 
>         depends on PPC_CELL_NATIVE
> 
> or similar.  Having PPC_CELL mean "native" / "raw" is not the
> way to go, there will be many many hypervisors in the future,
> it would be nice to have PPC_CELL mean just that, "support for
> the Cell architecture" in general, kernels running on various
> hypervisors will see the hardware virtualised to varying degrees.
> 
Yes, good point.

	Arnd <><

