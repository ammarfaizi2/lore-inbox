Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVCFWu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVCFWu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVCFWrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:47:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17829 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261585AbVCFWpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:45:51 -0500
Date: Sun, 6 Mar 2005 22:45:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Michael Geng <linux@MichaelGeng.de>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org,
       hpa@zytor.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/29] FAT: Updated FAT attributes patch
Message-ID: <20050306224544.GC5827@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Geng <linux@MichaelGeng.de>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org, hpa@zytor.com,
	Andrew Morton <akpm@osdl.org>
References: <87ll92rl6a.fsf@devron.myhome.or.jp> <87hdjqrl44.fsf@devron.myhome.or.jp> <87d5uerl2j.fsf_-_@devron.myhome.or.jp> <20050306155329.GA1436@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306155329.GA1436@t-online.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 04:53:29PM +0100, Michael Geng wrote:
> On Sun, Mar 06, 2005 at 03:42:28AM +0900, OGAWA Hirofumi wrote:
> > +/* <linux/videotext.h> has used 0x72 ('r') in collision, so skip a few */
> 
> These ioctls in videotext.h have been removed with 2.6.11. They were not used anywhere in the 
> kernel.

I'd rather avoid the collision anyway.
