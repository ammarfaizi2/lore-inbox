Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbSAJX22>; Thu, 10 Jan 2002 18:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289774AbSAJX2N>; Thu, 10 Jan 2002 18:28:13 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:64969 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289773AbSAJX2G>; Thu, 10 Jan 2002 18:28:06 -0500
Date: Thu, 10 Jan 2002 18:28:04 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pagecache lock ordering
Message-ID: <20020110182804.D8433@redhat.com>
In-Reply-To: <3C3CE5D6.2204BD27@zip.com.au> <Pine.LNX.4.21.0201101332560.1121-100000@localhost.localdomain> <3C3DFBEF.BA050536@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C3DFBEF.BA050536@zip.com.au>; from akpm@zip.com.au on Thu, Jan 10, 2002 at 12:39:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 12:39:11PM -0800, Andrew Morton wrote:
> I'm struggling to see a use for generic_buffer_fdatasync().  Maybe
> for a filesystem which doesn't implement ->writepage()?  Dunno.

I seem to be using it in aio.  Well, at least code based on it which 
seems to work for most filesystems for O_DATASYNC...

		-ben
-- 
Fish.
