Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSFFX3H>; Thu, 6 Jun 2002 19:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSFFX3G>; Thu, 6 Jun 2002 19:29:06 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:51678 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S312938AbSFFX3C>; Thu, 6 Jun 2002 19:29:02 -0400
Date: Fri, 7 Jun 2002 00:31:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic from 2.4.19-pre9-aa2
In-Reply-To: <83910000.1023400420@flay>
Message-ID: <Pine.LNX.4.21.0206070022400.3817-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002, Martin J. Bligh wrote:
> 
> Not sure why ksymoops is printing c0147dac from the trace, whilst 
> the stack says c0147dad, which seems to be the schedule call - 

Bug in ksymoops (had a misinitialized truncate_mask, which
removed the low bit by mistake): fixed in ksymoops 2.4.4.

Hugh

