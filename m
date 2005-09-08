Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVIHCVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVIHCVq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 22:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVIHCVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 22:21:46 -0400
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:45743 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S932566AbVIHCVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 22:21:45 -0400
Date: Thu, 8 Sep 2005 10:21:06 +0800
From: Bernard Blackham <b-lkml@blackham.com.au>
To: rob <rob.rice@fuse.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp
Message-ID: <20050908022105.GF6055@blackham.com.au>
References: <431E97E5.1080506@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431E97E5.1080506@fuse.net>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 03:33:57AM -0400, rob wrote:
> Is there some way to change the sowftware suspend2 scripts to work with the
> unpatched kernel software suspend

Yes. Just comment out everything in the suspend2 section, and enable
"UseSysfsPowerState disk". It really should get a less ugly name one
of these days :)

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
