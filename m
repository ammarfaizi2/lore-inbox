Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbTISUQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbTISUQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 16:16:42 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:61616 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S261697AbTISUQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 16:16:41 -0400
Date: Fri, 19 Sep 2003 22:16:34 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bind Mount Extensions ...
Message-ID: <20030919201634.GF3978@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <20030919192937.GA31111@DUK2.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030919192937.GA31111@DUK2.13thfloor.at>
X-Operating-System: vega Linux 2.6.0-test3 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This would be VERY usefull. Here, we're using chroot'ed apache servers
on Solaris and on Linux. For security reasons, the document root
is mounted from "outside of chroot" into "inside of chroot" with
read-only mode using lofs on Solaris, and it does the job.

However we can't do this on Linux, or we must use nfs ro mount from
localhost which is quite ugly, and much more slower as well I think ;-)

On Fri, Sep 19, 2003 at 09:29:37PM +0200, Herbert Poetzl wrote:
> 
> Hi Andrew!
> 
> just verified that the patch still applies on
> linux-2.6.0-test5 and linux-2.6.0-test5-mm3 
> without any issues ...
> 
> FYI, this patch allows RO --bind mounts to
> behave like other ro mounted filesystems ...
> 
> do you see any possibility to get this in
> for extensive testing in the near future?
> 
> TIA,
> Herbert

- Gábor (larta'H)
