Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318265AbSG3N0d>; Tue, 30 Jul 2002 09:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSG3N0d>; Tue, 30 Jul 2002 09:26:33 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:63670 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318265AbSG3N0c>; Tue, 30 Jul 2002 09:26:32 -0400
Date: Tue, 30 Jul 2002 18:59:51 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020730185951.B2909@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20020730054111.GA1159@dualathlon.random> <20020730084939.A8978@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020730084939.A8978@redhat.com>; from bcrl@redhat.com on Tue, Jul 30, 2002 at 08:49:39AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 08:49:39AM -0400, Benjamin LaHaise wrote:
> 
>  Anyways, the core is pretty much ready, so 

Hey Ben, That sounds great. Have been looking forward to it 
to find out how much has changed and if you've left anything 
for us to do :) (other than docs and driver fixes :( ) 

I did have an updated version of the bio traversal patch 
(for 2.5.29) that avoids modifications to the bv_offset/bv_len
fields by the block layer, though I don't know if you 
still need it. Besides, you probably wouldn't run into
those cases often, as the partial request completions 
are probably rare. But just as a fyi ... 

Regards
Suparna

> 
