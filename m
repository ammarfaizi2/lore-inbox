Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVAITkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVAITkQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 14:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVAITkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 14:40:16 -0500
Received: from p3EE2B9FA.dip.t-dialin.net ([62.226.185.250]:45072 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261728AbVAITkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 14:40:13 -0500
Date: Sun, 9 Jan 2005 20:39:44 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: removing bcopy... because it's half broken
Message-ID: <20050109193944.GA19083@linux-mips.org>
References: <20050109192305.GA7476@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050109192305.GA7476@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 07:23:05PM +0000, Arjan van de Ven wrote:

For a long time MIPS has defined __HAVE_ARCH_BCOPY without actually
implementing bcopy, so any kernel use did result in a build error.  As
far as I can recall all that it has caught were a few missconfigured
gccs, so yes, away with it.

  Ralf
