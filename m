Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbSJNUbR>; Mon, 14 Oct 2002 16:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262188AbSJNUbR>; Mon, 14 Oct 2002 16:31:17 -0400
Received: from pcp810151pcs.nrockv01.md.comcast.net ([68.49.85.67]:29572 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S262187AbSJNUbQ>;
	Mon, 14 Oct 2002 16:31:16 -0400
Date: Mon, 14 Oct 2002 16:37:07 -0400
From: Olivier Galibert <galibert@pobox.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Daniele Lugli <genlogic@inrete.it>, linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
Message-ID: <20021014163707.A2809@zalem.puupuu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Daniele Lugli <genlogic@inrete.it>, linux-kernel@vger.kernel.org
References: <3DAB1F00.667B82B5@inrete.it> <Pine.LNX.3.95.1021014162539.16867B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1021014162539.16867B-100000@chaos.analogic.com>; from root@chaos.analogic.com on Mon, Oct 14, 2002 at 04:33:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 04:33:50PM -0400, Richard B. Johnson wrote:
> > #define current get_current()

> This cannot be the reason for your problem. The name of a structure
> member has no connection whatsoever with the name of any function or
> definition.

You forgot the effect of the parenthesis.  This isn't a name-changing
macro, this is a variable-to-function-call changing macro.

  OG.
