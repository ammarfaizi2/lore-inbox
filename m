Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVAaOEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVAaOEZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVAaOEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:04:25 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14275 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261206AbVAaOEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:04:23 -0500
Date: Tue, 1 Feb 2005 01:04:00 +1100
From: Greg Banks <gnb@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] unexport get_wchan
Message-ID: <20050131140400.GA4038@sgi.com>
References: <20050131133617.GJ18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131133617.GJ18316@stusta.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 02:36:17PM +0100, Adrian Bunk wrote:
> The only user of get_wchan I was able to find is the proc fs - and proc 
> can't be built modular.
> 
> Is the patch below to remove the export of get_wchan correct or did I 
> oversee something?

I have an oprofile patch queued up which uses get_wchan.  Oprofile
can be built modular.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
