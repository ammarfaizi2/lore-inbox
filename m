Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbTABFfP>; Thu, 2 Jan 2003 00:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbTABFfP>; Thu, 2 Jan 2003 00:35:15 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:32986 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S265612AbTABFfO>; Thu, 2 Jan 2003 00:35:14 -0500
Date: Thu, 2 Jan 2003 00:43:37 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Linux v2.5.54 - OHCI-HCD build fails
Message-ID: <20030102054337.GA1418@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com> <20030102045245.GA1464@Master.Wizards> <20030102050007.GB1464@Master.Wizards> <pan.2003.01.02.05.16.23.282892@voxel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2003.01.02.05.16.23.282892@voxel.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 12:16:33AM -0500, Andres Salomon wrote:
> This fixes it.  data0 and data1 are defined inside a DEBUG #ifdef context,
> and used outside of it.
>  

Um - the patch is backwards.
The lines already existed at 218 & 219. Moving em up to 9 solved the problem
Thanks for the hint.


-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker
  #cooker = moderated Mandrake Cooker

