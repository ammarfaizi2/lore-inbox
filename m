Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272342AbRHXXVs>; Fri, 24 Aug 2001 19:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272343AbRHXXVi>; Fri, 24 Aug 2001 19:21:38 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:17013 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272342AbRHXXV2>; Fri, 24 Aug 2001 19:21:28 -0400
Date: Fri, 24 Aug 2001 19:21:43 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: Brad Chapman <kakadu_croc@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010824224232.52238.qmail@web10908.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0108241919080.1398-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, Brad Chapman wrote:

> 	This way, some hackers can use the two-arg min()/max() inside an #ifdef block,
> other hackers can use the three-arg min()/max() inside an #ifdef block,
> and people who don't care can select either.

Have you no taste?  Use of #ifdef's should be minimised as much as
possible.  For this kind of construct, the spurious preprocessor usage
just makes me want to vomit.

		-ben

