Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271037AbTHLR4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271043AbTHLR4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:56:53 -0400
Received: from newpeace.netnation.com ([204.174.223.7]:32719 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP id S271037AbTHLR4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:56:52 -0400
Date: Tue, 12 Aug 2003 10:56:51 -0700
From: Simon Kirby <sim@netnation.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O14int
Message-ID: <20030812175651.GA12036@netnation.com>
References: <20030808220821.61cb7174.lista1@telia.com> <200308091036.18208.kernel@kolivas.org> <20030810084827.GA30869@netnation.com> <200308101906.34807.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308101906.34807.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 07:06:34PM +1000, Con Kolivas wrote:

> Is this with or without my changes? The old scheduler was not very scalable; 
> that's why we moved. The new one has other intrinsic issues that I (and 
> others) have been trying to address, but is much much more scalable. It was 
> not possible to make the old one more scalable, but it is possible to make 
> this one more interactive.

Without your changes.  Are you changing the design or just tuning certain
cases?  I was talking more about the theory behind the scheduling
decisions and not about particular cases.

The O(1) scheduler changes definitely help scalability and I don't have
any problem with that change (unless it introduced the behavior I'm
talking about).

Simon-
