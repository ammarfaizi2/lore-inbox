Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTJNV5v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbTJNV5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:57:51 -0400
Received: from hockin.org ([66.35.79.110]:58380 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262429AbTJNV5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:57:50 -0400
Date: Tue, 14 Oct 2003 14:44:37 -0700
From: Tim Hockin <thockin@hockin.org>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: sankar <san_madhav@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Question on atomic_inc/dec
Message-ID: <20031014214437.GA30302@hockin.org>
References: <A20D5638D741DD4DBAAB80A95012C0AED78649@orsmsx409.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A20D5638D741DD4DBAAB80A95012C0AED78649@orsmsx409.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 02:17:49PM -0700, Perez-Gonzalez, Inaky wrote:
> It will be in include/asm/atomic.h; however, it is not wise to
> use directly the kernel stuff unless you are coding kernel stuff.

Is there any reason NOT to use the atomic ops in user-space?  I mean, are
they privileged on some architectures, or ...?  It seems like some
user-space apps might really benefit from simple atomic ops.  Or at least,
kernel-coders writing in userspace could sure use simple atomic ops :)

Tim

-- 
Notice that as computers are becoming easier and easier to use,
suddenly there's a big market for "Dummies" books.  Cause and effect,
or merely an ironic juxtaposition of unrelated facts?

