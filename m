Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVADKnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVADKnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 05:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVADKnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 05:43:41 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:8049 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261597AbVADKnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 05:43:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OKJ82NJBRRxJ8zQdmWzncF3lY15NMSPnmIlBFxrNwds1/W5VrANZZzvMJ9yDshFba6yspN417MKnk3miuKd6R0qXKm3W6RRyeG3m52DbylrVETbDu9w8iFfk2xNW6iSqFnQ6A3jvXbWln4T/ATLk/seHqJOX/FmOBFTH9gSMtQo=
Message-ID: <5a2cf1f6050104024368eb1424@mail.gmail.com>
Date: Tue, 4 Jan 2005 11:43:39 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: Norbert van Nobelen <norbert-kernel@edusupport.nl>
Subject: Re: 50% CPU user usage but top doesn't list any CPU unfriendly task
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200501040851.23287.norbert-kernel@edusupport.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5a2cf1f6050103134611114dbd@mail.gmail.com>
	 <200501040851.23287.norbert-kernel@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005 08:51:23 +0100, Norbert van Nobelen
<norbert-kernel@edusupport.nl> wrote:
> The load and the CPU useage are two separate things:
> Load: Defined by a programmer on an estimate on which his program is running
> 100% fulltime, thus consuming little or more CPU/IO.
> The interesting program you mention is the VoIP application. Is this program
> multithreaded and is every thread using a little bit of CPU? Than it quickly
> adds up to the mentioned 40%. 

There are some threads in that app, not that many, and none show in
the top listing (which displays at least 30 entries). So I don't think
this sum scenario is valid.

>The load is than also easily reached.
