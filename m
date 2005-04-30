Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVD3Pdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVD3Pdx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 11:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVD3Pdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 11:33:53 -0400
Received: from pD9E8B135.dip.t-dialin.net ([217.232.177.53]:48644 "EHLO
	gateway2.croq.loc") by vger.kernel.org with ESMTP id S261253AbVD3Pdw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 11:33:52 -0400
Message-ID: <4273A51E.6080503@free.fr>
Date: Sat, 30 Apr 2005 17:32:46 +0200
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setitimer timer expires too early
References: <42726DDD.1010204@free.fr> <427285CC.9090300@grupopie.com> <29495f1d050429142515f7e2c4@mail.gmail.com>
In-Reply-To: <29495f1d050429142515f7e2c4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nish Aravamudan wrote:

> Perhaps not discussed before, but definitely a known issue. Check out
> sys_nanosleep(), which adds an extra jiffy to the delay if there is
> going to be one. My patch, which uses human-time (or at least more so
> than currently), should not have issues like this.

What would be then the most precise and reliable delaying possibility in 
the present kernel?

