Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311112AbSCHUun>; Fri, 8 Mar 2002 15:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311115AbSCHUug>; Fri, 8 Mar 2002 15:50:36 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:60670 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311112AbSCHUuW>; Fri, 8 Mar 2002 15:50:22 -0500
Date: Fri, 08 Mar 2002 12:49:37 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] stop null ptr deference in __alloc_pages
Message-ID: <12160000.1015620577@flay>
In-Reply-To: <Pine.LNX.4.33.0203081207360.18968-100000@dbear.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.33.0203081207360.18968-100000@dbear.engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you applied an SGI patch that makes the zonelist contain all the zones
> of your machine, then the zonelist should not be NULL.
> If you allocate memory with gfp_mask & GFP_ZONEMASK == GFP_NORMAL from a
> HIGHMEM only node, then the first entry on the corresponding zonelist
> should be the first NORMAL zone on some other node.
> Am I missing something here ?

You're missing the fact that I'm missing the SGI patch ;-)

M.

