Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932111AbWELPEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWELPEN (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 12 May 2006 11:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWELPEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:04:13 -0400
Received: from 213-140-2-76.ip.fastwebnet.it ([213.140.2.76]:41632 "EHLO
	aa009msg.fastweb.it") by vger.kernel.org with ESMTP id S932111AbWELPEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:04:12 -0400
Date: Thu, 11 May 2006 17:42:41 +0200
From: Andrea Gelmini <andrea.gelmini@gmail.com>
To: Paul Slootman <paul+nospam@wurtel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [dm-crypt] dm-crypt is broken and causes massive data corruption
Message-ID: <20060511154241.GA5959@gelma.net>
References: <445F7DCC.2000508@igd.fraunhofer.de> <20060509190457.GL16180@agk.surrey.redhat.com> <e3vkeh$12h$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3vkeh$12h$1@news.cistron.nl>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 03:15:29PM +0000, Paul Slootman wrote:
> A data point:
> 
> I'm running my /home on reiserfs3 over dm-crypt over lvm over raid5 for
> at least a year now, without any problems. Currently running 2.6.13.4
> (that's my "stable" work system...).

It seems the write pattern is important... I can replicate corruption
copying giga of data from an locale attached IDE disk. Do you write mostly
from network or from slow devices?

ciao,
gelma
