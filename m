Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271197AbTHLVRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271195AbTHLVQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:16:19 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:3992
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271194AbTHLVQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:16:03 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Simon Kirby <sim@netnation.com>
Subject: Re: [PATCH]O14int
Date: Wed, 13 Aug 2003 07:21:43 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20030808220821.61cb7174.lista1@telia.com> <200308101906.34807.kernel@kolivas.org> <20030812175651.GA12036@netnation.com>
In-Reply-To: <20030812175651.GA12036@netnation.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308130721.43967.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003 03:56, Simon Kirby wrote:
> On Sun, Aug 10, 2003 at 07:06:34PM +1000, Con Kolivas wrote:
> > Is this with or without my changes? The old scheduler was not very
> > scalable; that's why we moved. The new one has other intrinsic issues
> > that I (and others) have been trying to address, but is much much more
> > scalable. It was not possible to make the old one more scalable, but it
> > is possible to make this one more interactive.
>
> Without your changes.  Are you changing the design or just tuning certain
> cases?  I was talking more about the theory behind the scheduling
> decisions and not about particular cases.

I'm just changing the algorithm that gives priority boost or penalty, and 
creating code to further feedback into that algorithm.

> The O(1) scheduler changes definitely help scalability and I don't have
> any problem with that change (unless it introduced the behavior I'm
> talking about).

