Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbTFSBoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbTFSBoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:44:39 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:60051 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265689AbTFSBoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:44:38 -0400
Date: Wed, 18 Jun 2003 18:59:30 -0700
From: Andrew Morton <akpm@digeo.com>
To: Greg Norris <haphazard@kc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72 oops (scheduling while atomic)
Message-Id: <20030618185930.672e41a0.akpm@digeo.com>
In-Reply-To: <20030619014822.GA5705@glitch.localdomain>
References: <20030617143551.GA3057@glitch.localdomain>
	<20030619014822.GA5705@glitch.localdomain>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2003 01:58:36.0581 (UTC) FILETIME=[4BCB1550:01C33606]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Norris <haphazard@kc.rr.com> wrote:
>
> I just re-tested with 2.5.72-bk1, which still experiences the problem. 
>  I enabled all of the debugging options this time, however, and so
>  captured what I hope to be a more informative oops.  The .config was
>  otherwise unchanged.
> 
>  Let me know if I can provide any additional information.
> 
> 

Try booting with the `initcall_debug' kernel boot option. 
All of the startup messages would be interesting.


