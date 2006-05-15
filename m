Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbWEOSfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWEOSfg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWEOSfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:35:36 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:7391 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S965123AbWEOSff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:35:35 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc4 6/6] Remove some of the kmemleak false positives
Date: Mon, 15 May 2006 20:32:26 +0200
User-Agent: KMail/1.9.1
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <20060513155757.8848.11980.stgit@localhost.localdomain> <200605141939.51288.ioe-lkml@rameria.de> <b0943d9e0605150312m22559450p28c44a17d88b6325@mail.gmail.com>
In-Reply-To: <b0943d9e0605150312m22559450p28c44a17d88b6325@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152032.26974.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 15. May 2006 12:12, Catalin Marinas wrote:
> I haven't looked at RT-Mutex but are more than the 2 bottom bits used
> for this? 

No. Only 2 bits.

> If not, they can be masked out before look-up. 

Yes, just do it that way, if it is possible.


Regards

Ingo Oeser
