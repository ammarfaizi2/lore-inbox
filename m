Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTKTUpM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 15:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTKTUpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 15:45:12 -0500
Received: from dp.samba.org ([66.70.73.150]:40888 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261931AbTKTUpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 15:45:10 -0500
Date: Fri, 21 Nov 2003 07:28:15 +1100
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: use ELF sections for get_wchan()
Message-ID: <20031120202815.GB11889@krispykreme>
References: <20031118074448.GD19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031118074448.GD19856@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> I noticed a bunch of "FIXME: this depends on the order of these
> functions" comments in/around wchan calculations.
> 
> So I decided I'd remove the dependency on the order of the functions by
> dumping them all into an ELF section with clear delimiters.

I like it. At the moment wchan is next to useless because everything
ends up in down* or something similar.

Anton
