Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVDTTyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVDTTyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 15:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVDTTyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 15:54:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40891 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261753AbVDTTyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 15:54:05 -0400
Date: Wed, 20 Apr 2005 12:01:26 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rename rw_verify_area() to rw_access_ok()
Message-ID: <20050420150126.GA7731@logos.cnet>
References: <Pine.LNX.4.62.0504172346120.2586@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504172346120.2586@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2005 at 11:50:35PM +0200, Jesper Juhl wrote:
> verify_area() will soon be dead and gone, replaced by access_ok(), thus 
> the function named rw_verify_area() is badly named and should be renamed. 
> This patch renames rw_verify_area to rw_access_ok which seems more 
> appropriate (it also updates all callers of the functions as well as 
> references to it in comments).

Not that I care too much, but, rw_verify_area() has nothing to do with 
verify_area/access_ok functions.

I dont see real need to rename this function. 

