Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264410AbTCYWSx>; Tue, 25 Mar 2003 17:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264406AbTCYWR7>; Tue, 25 Mar 2003 17:17:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:42938 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264399AbTCYWRu>;
	Tue, 25 Mar 2003 17:17:50 -0500
Date: Tue, 25 Mar 2003 15:31:24 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Ben Collins <bcollins@debian.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] increase BUS_ID_SIZE to 20
In-Reply-To: <20030318030045.GA367@phunnypharm.org>
Message-ID: <Pine.LNX.4.33.0303251529140.999-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Mar 2003, Ben Collins wrote:

> I've tried to figure a way around this without adding back a lot of
> overhead, but I can't.
> 
> The reasoning, is the ieee1394 node's onyl way of a real unique
> identifier is the EUI (the 64bit GUID). It's represented as a 16 digit
> hex. However, each node additionally ca have unit directories.

> Please consider applying this patch.

Alright, you win. I'll add it to my tree.


	-pat

