Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315391AbSEGKKh>; Tue, 7 May 2002 06:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315393AbSEGKKg>; Tue, 7 May 2002 06:10:36 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:61093 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315391AbSEGKKg>; Tue, 7 May 2002 06:10:36 -0400
Date: Tue, 7 May 2002 15:41:35 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        linux-mm@kvack.org
Subject: Re: [PATCH]Fix: Init page count for all pages during higher order allocs
Message-ID: <20020507154135.A1722@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <20020503175438.A1816@in.ibm.com> <Pine.LNX.4.21.0205031438310.1408-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 02:46:34PM +0100, Hugh Dickins wrote:
> On Fri, 3 May 2002, Suparna Bhattacharya wrote:
> > 
> > For example we have an option that tries to exclude non-kernel
> > pages from the dump based on a simple heuristic of checking the
> > PG_lru flag (actually exclude LRU pages and unreferenced pages). 
> 
> I hadn't thought of using PG_lru (last thought about it before
> anonymous pages were put on the LRU in 2.4.14): good idea,

Owe that one to Andrew Morton mostly for suggesting a PG_lru 
check in the context of a way to identify Anon pages.

Regards
Suparna
