Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265813AbUF2R2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265813AbUF2R2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 13:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUF2R2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 13:28:17 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:63890 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265813AbUF2R2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 13:28:15 -0400
Date: Tue, 29 Jun 2004 19:28:15 +0200
From: bert hubert <ahu@ds9a.nl>
To: Debi Janos <debi.janos@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
Message-ID: <20040629172815.GA6625@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Debi Janos <debi.janos@freemail.hu>, linux-kernel@vger.kernel.org
References: <20040629154551.GA6181@outpost.ds9a.nl> <freemail.20040529185706.6941@fm3.freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <freemail.20040529185706.6941@fm3.freemail.hu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 06:57:06PM +0200, Debi Janos wrote:

> http://packages.gentoo.org/

Run

tcpdump -i any -s 0 -w workingkernel host 198.63.211.232 
and
tcpdump -i any -s 0 -w brokenkernel host 198.63.211.232 

While trying to connect with both a workingkernel and a brokenkernel.

Then attach both these files in a message, either to me or to the list.

This will allow us to see what is going on.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
