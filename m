Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWFNEyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWFNEyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 00:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWFNEyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 00:54:22 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:57731 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932340AbWFNEyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 00:54:21 -0400
Message-ID: <448F967A.8070801@ens-lyon.org>
Date: Wed, 14 Jun 2006 00:54:18 -0400
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org> <448F2A49.5020809@google.com> <20060613154031.A6276@openss7.org> <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse>
In-Reply-To: <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:
> At least some of us feel like stable module APIs should be explicitly
> discouraged, because we don't want to offer comfort for code that
> refuses to live in the tree (since getting said code into the tree is
> often a goal).
>
> I'm curious now too - can you name some non-GPL non-proprietary
> modules we should be concerned about? I'd think most of the possible
> examples (not sure what they are) would be better off dual-licensed
> (one license being GPL) and in-kernel.

What about GPL modules that don't want to get merged ? I don't know any
such module that could use this API. But at least there are some webcam
drivers that don't seem to want to be merged (I don't know why).

I agree with making life hard for proprietary modules. I agree that
maintaining a stable API is hard. But I don't see the actual point of
discouraging modules to stay out of tree.

Brice

