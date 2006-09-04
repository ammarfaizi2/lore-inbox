Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWIDN6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWIDN6p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWIDN6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:58:45 -0400
Received: from c-66-30-195-131.hsd1.ma.comcast.net ([66.30.195.131]:40902 "EHLO
	pressure.kernelslacker.org") by vger.kernel.org with ESMTP
	id S1751391AbWIDN6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:58:43 -0400
Date: Mon, 4 Sep 2006 10:03:33 -0400
From: Dave Jones <davej@redhat.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: Re: 2.6.18rc5: NFSd possible recursive locking
Message-ID: <20060904140333.GF6778@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org,
	trond.myklebust@fys.uio.no
References: <m3slj8ae84.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3slj8ae84.fsf@defiant.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2006 at 10:26:35PM +0200, Krzysztof Halasa wrote:
 > Hi,
 > 
 > another one (details available on request):
 > 
 > [ INFO: possible recursive locking detected ]
 > ---------------------------------------------
 > nfsd/1566 is trying to acquire lock:
 >  (&inode->i_mutex){--..}, at: [<c0334e0c>] mutex_lock+0x1c/0x20
 > 
 > but task is already holding lock:
 >  (&inode->i_mutex){--..}, at: [<c0334e0c>] mutex_lock+0x1c/0x20

This one has been there for a month or so..
http://bugme.osdl.org/show_bug.cgi?id=6918

	Dave
 
