Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317141AbSG1ToC>; Sun, 28 Jul 2002 15:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSG1ToC>; Sun, 28 Jul 2002 15:44:02 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:58092 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S317141AbSG1ToB>; Sun, 28 Jul 2002 15:44:01 -0400
Subject: RE: About the need of a swap area
From: Ed Sweetman <safemode@speakeasy.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Buddy Lumpkin <b.lumpkin@attbi.com>, Ville Herva <vherva@niksula.hut.fi>,
       Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0207281629010.3086-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0207281629010.3086-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 28 Jul 2002 15:47:20 -0400
Message-Id: <1027885641.4228.143.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-28 at 15:29, Rik van Riel wrote:
> On 28 Jul 2002, Ed Sweetman wrote:
> 
> > If you bother to do any real tests you'd see that linux will swap when
> > nothing is going on and this doesn't hinder anything.
> 
> Linux only puts pages in swap when it's low on free physical memory.

Perhaps, but linux considers disk cache as "in use" memory and most
people would consider it free memory that's just temporarily being taken
advantage of "in case".  Linux will still swap even if 60% of ram is
filesystem cache. I dont have a problem with it, was just stating some
real observations.  

 
> regards,
> 
> Rik
> -- 


