Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTFBPBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTFBPBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:01:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15021 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262382AbTFBPBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:01:23 -0400
Date: Mon, 2 Jun 2003 17:14:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
In-Reply-To: <1054560974.1918.2.camel@iso-8590-lx.zeusinc.com>
Message-ID: <Pine.LNX.4.44.0306021712530.7224-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Jun 2003, Tom Sightler wrote:

> Sorry, this is my fault, I'm actually renicing the process to '10' not
> '-10' that's a typo.  I tested this again this morning to make sure.  
> I'm renicing this as a regular user, I don't think that a regular user
> is allowed to renice to a negative value.

hm. Which process is generating the sound? But yes, if a positive renicing
for the wine process solved the audio problem then this is bad.

	Ingo

