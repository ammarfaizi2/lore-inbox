Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271177AbTHHCwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 22:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271183AbTHHCwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 22:52:55 -0400
Received: from vitelus.com ([64.81.243.207]:29898 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S271177AbTHHCwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 22:52:54 -0400
Date: Thu, 7 Aug 2003 19:49:09 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Bernardo Innocenti <bernie@develer.com>
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Big kernel size increase with gcc 3.4
Message-ID: <20030808024909.GT2712@vitelus.com>
References: <3F330D46.8020508@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F330D46.8020508@develer.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 04:39:02AM +0200, Bernardo Innocenti wrote:
> - same optimization flags: -m5307 -O2 -fno-strict-aliasing
>      -fno-common -fno-builtin -fomit-frame-pointer

You should try -Os if you want to optimize for size.
