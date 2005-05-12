Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVELQna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVELQna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 12:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVELQna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 12:43:30 -0400
Received: from mail.uni-ulm.de ([134.60.1.1]:21490 "EHLO mail.uni-ulm.de")
	by vger.kernel.org with ESMTP id S262075AbVELQn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 12:43:28 -0400
Date: Thu, 12 May 2005 18:44:13 +0200
From: Markus Klotzbuecher <mk@creamnet.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
Message-ID: <20050512164413.GA14099@mary>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	linux-kernel@vger.kernel.org
References: <20050509183135.GB27743@mary> <20050512121842.GA20388@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050512121842.GA20388@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.8i
X-DCC-SIHOPE-DCC-3-Metrics: gemini 1085; Body=2 Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joern,

On Thu, May 12, 2005 at 02:18:42PM +0200, Jörn Engel wrote:

> Just out of curiosity: how do you perform the copy-up operation?
> In-kernel copies of large files are a huge problem and for union-mount
> purposes, I'm clueless about how to fix things.

Basically I open the source and the target file on the lower file
systems for reading and writing respectively, then read and write page
sized chunks of data until all has been copied. Obviously not ideal
for large files, but I had no better idea so far.

Markus
