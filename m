Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270189AbTGMJMe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 05:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270190AbTGMJMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 05:12:34 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:52493 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270189AbTGMJMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 05:12:32 -0400
Date: Sun, 13 Jul 2003 10:27:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: yuval yeret <yuval_yeret@hotmail.com>
Cc: linux-kernel@vger.kernel.org, yuval@exanet.com
Subject: Re: 2.4.18-24 SMP Machine stuck in zombie state after kernel Oops in devfs_d_iput
Message-ID: <20030713102716.C24901@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	yuval yeret <yuval_yeret@hotmail.com>, linux-kernel@vger.kernel.org,
	yuval@exanet.com
References: <BAY2-F10090EVrQQehr00006765@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BAY2-F10090EVrQQehr00006765@hotmail.com>; from yuval_yeret@hotmail.com on Sun, Jul 13, 2003 at 12:12:42PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 12:12:42PM +0300, yuval yeret wrote:
> Hi,
> 
> Tried to find information about a kernel OOPS I've seen twice already on two 
> different machines - but nothing seems to be said about this in the list 
> archives or anywhere else for that matter (except someone saw this a while 
> ago on a 2.5.X kernel - 
> http://groups.google.com/groups?q=devfs_d_iput&hl=en&lr=lang_en|lang_iw&ie=UTF-8&oe=UTF-8&safe=off&selm=20030424211014%242fa9%40gated-at.bofh.it&rnum=1 

I'd suggest just turning devfs off, that'll help you a lot.

If you don't like that at least try to reproduce with a mainline kernel.
