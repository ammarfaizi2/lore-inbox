Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTJITgL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTJITgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:36:11 -0400
Received: from intra.cyclades.com ([64.186.161.6]:35496 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262400AbTJITe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:34:56 -0400
Date: Thu, 9 Oct 2003 16:37:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Magnus Andersson <magan029@student.liu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 O_DIRECT memory leak?!?
In-Reply-To: <20031008180919.A6172@student.liu.se>
Message-ID: <Pine.LNX.4.44.0310091637270.3040-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Oct 2003, Magnus Andersson wrote:

> Hello!
> 
> If I open one file a lot of times using the flag O_DIRECT,
> memory seems to be be lost and never given back to the system.
> This is happening on some kernels, see below for which ones I tried.
> 
> Attached program will produce this behavior, also attached 
> is the output from vmstat while running the program.

Magnus,

That memory will be freed as soon as there's memory pressure so its not a 
memory leak.



