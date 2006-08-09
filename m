Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbWHIErl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWHIErl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 00:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWHIErl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 00:47:41 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:34756
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1030469AbWHIErk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 00:47:40 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: -mm patch] bcm43xx_main.c: remove 3 functions
Date: Wed, 9 Aug 2006 06:47:28 +0200
User-Agent: KMail/1.9.1
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608082032.38365.mb@bu3sch.de> <20060808194231.GQ3691@stusta.de>
In-Reply-To: <20060808194231.GQ3691@stusta.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com,
       jgarzik@pobox.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090647.31890.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 21:42, you wrote:
> And it seems to be your fault.  ;-)

Uh, oh. I'm trapped.

> commit 58e5528ee464d38040b9489e10033c9387a10d56
> Author: Michael Buesch <mb@bu3sch.de>
> Date:   Sat Jul 8 22:02:18 2006 +0200
> 
>     [PATCH] bcm43xx: init routine rewrite

Ah, I guessed it.
This was caused by some merge-race ;)
Will send a fix for this, soon.

-- 
Greetings Michael.
