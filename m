Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287828AbSA2AH5>; Mon, 28 Jan 2002 19:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSA2AHr>; Mon, 28 Jan 2002 19:07:47 -0500
Received: from zero.tech9.net ([209.61.188.187]:11278 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287809AbSA2AHi>;
	Mon, 28 Jan 2002 19:07:38 -0500
Subject: Re: Rik van Riel's vm-rmap
From: Robert Love <rml@tech9.net>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <1012262826.1634.1.camel@tiger>
In-Reply-To: <Pine.LNX.4.33L.0201280613510.32617-100000@imladris.surriel.com> 
	<1012262826.1634.1.camel@tiger>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 28 Jan 2002 19:12:45 -0500
Message-Id: <1012263182.817.9.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-28 at 19:07, Louis Garcia wrote:
> Does this patch work well with Andrew's low-latency patch?

There will be failed hunks in the VM code (specifically vmscan.c), but
you can safely ignore them.  So, yes, it works.

	Robert Love

