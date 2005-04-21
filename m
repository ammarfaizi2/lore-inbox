Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVDUGsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVDUGsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 02:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVDUGsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 02:48:16 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:16092 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261241AbVDUGsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 02:48:11 -0400
Date: Thu, 21 Apr 2005 08:48:10 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pekka Enberg <penberg@gmail.com>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi
Subject: Re: [PATCH] remove some usesless casts
Message-ID: <20050421064810.GB13329@wohnheim.fh-wedel.de>
References: <20050420065500.GA24213@wohnheim.fh-wedel.de> <4266732A.6050508@lougher.demon.co.uk> <20050420213336.GA22421@wohnheim.fh-wedel.de> <4266C0C3.7070002@lougher.demon.co.uk> <84144f0205042023366dc0b16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84144f0205042023366dc0b16@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 April 2005 09:36:18 +0300, Pekka Enberg wrote:
> 
> I think Jörn means that if you need an opaque data type, use void
> pointers (which are automatically cast to the proper type) and that
> all other casts are a design smell (except for the one or two special
> cases where you actually need them).

Two of my patches agree with you, two don't.  Really, in almost all
cases, casts are a Bad Idea(tm).  Almost always, there is _something_
better.  In some cases, this comes down to void pointers, yes.

Jörn

-- 
I can say that I spend most of my time fixing bugs even if I have lots
of new features to implement in mind, but I give bugs more priority.
-- Andrea Arcangeli, 2000
