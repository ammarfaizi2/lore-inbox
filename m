Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268193AbUIPUDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268193AbUIPUDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 16:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268183AbUIPUDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 16:03:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:714 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268193AbUIPUCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 16:02:40 -0400
Date: Thu, 16 Sep 2004 16:02:09 -0400
From: Alan Cox <alan@redhat.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: tty drivers take two
Message-ID: <20040916200209.GB16474@devserv.devel.redhat.com>
References: <20040916143057.GA15163@devserv.devel.redhat.com> <1095363506.2937.9.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095363506.2937.9.camel@deimos.microgate.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 02:38:26PM -0500, Paul Fulghum wrote:
> purpose. There is no reason to assign
> N_TTY ldisc to a tty instance that
> is then immediately thrown away. The lines
> that drop the reference to the current ldisc
> are, of course, still needed.

Yep. Your previous fixes there are on my todo list

