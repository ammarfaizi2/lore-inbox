Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268448AbUHNLTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268448AbUHNLTt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 07:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268436AbUHNLTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 07:19:49 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:17610 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S268454AbUHNLTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 07:19:41 -0400
X-Sender-Authentication: net64
Date: Sat, 14 Aug 2004 13:19:38 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, willy@w.ods.org
Subject: Re: Linux v2.6.8
Message-Id: <20040814131938.46c1129c.skraw@ithnet.com>
In-Reply-To: <411DE9B6.80806@pobox.com>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
	<411DE9B6.80806@pobox.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2004 06:30:14 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Linus Torvalds wrote:
> > Matthew Wilcox:
> >   o Remove fcntl f_op
> 
> Any chance of a 2.6.9 with working NFS?
> 
> See attached patch, which came from this thread:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109244804202259&w=2
> http://marc.theaimsgroup.com/?t=109244611400001&r=1&w=2

Hi Jeff,

I just fell into the same hole. On my box (x86) only write-access to nfs
produces the known problem.
I can confirm that your patch solves it.
I very much vote for 2.6.9 NFS-bugfix. This is a real show-stopper.
 
Regards,
Stephan
