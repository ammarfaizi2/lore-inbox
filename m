Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263234AbTCNEQu>; Thu, 13 Mar 2003 23:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263239AbTCNEQu>; Thu, 13 Mar 2003 23:16:50 -0500
Received: from tomts23.bellnexxia.net ([209.226.175.185]:45972 "EHLO
	tomts23-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263234AbTCNEQt>; Thu, 13 Mar 2003 23:16:49 -0500
Subject: Re: 2.5.64-mm>1 Problems starting gnome?
From: Shane Shrybman <shrybman@sympatico.ca>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3E7157C4.2040901@cyberone.com.au>
References: <1047613046.2267.97.camel@mars.goatskin.org>
	 <3E7157C4.2040901@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1047616055.2274.2.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 23:27:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 23:17, Nick Piggin wrote:
> Shane Shrybman wrote:
> 
> >Hi Andrew et al.
> >
> >I am having problems starting gnome in the 2.5.64-mmX (X>1). 2.5.64 and
> >2.5.64-mm1 work ok, 2.5.64-mm2 doesn't compile for me and the more
> >recent -mm don't work.
> >
> Processes getting stuck in D is most likely to be an anticipatory
> scheduler bug. Please boot with elevator=deadline. Thanks.

Thanks! That does appear to have done the trick. I am in -mm6 now :)

Shane

