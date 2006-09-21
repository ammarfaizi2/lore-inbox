Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWIUWcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWIUWcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWIUWcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:32:18 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:61655 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932066AbWIUWcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:32:17 -0400
Date: Thu, 21 Sep 2006 15:20:24 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Sean <seanlkml@sympatico.ca>
cc: Dax Kelson <dax@gurulabs.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
In-Reply-To: <BAYC1-PASMTP04A6968C3ABEA48C9AD2E5AE200@CEZ.ICE>  <20060921182554.23044ca3.seanlkml@sympatico.ca>
Message-ID: <Pine.LNX.4.63.0609211517380.17238@qynat.qvtvafvgr.pbz>
References: <1158870777.24172.23.camel@mentorng.gurulabs.com><20060921204250
 .GN13641@csclub.uwaterloo.ca><20060921171747.9ae2b42e.seanlkml@sympatico.ca
 ><1158874875.24172.47.camel@mentorng.gurulabs.com><BAYC1-PASMTP025A72C81CFE
 009C3BB5A5AE200@CEZ.ICE><20060921175717.272c58ee.seanlkml@sympatico.ca><Pin
 e.LNX.4.63.0609211455570.17238@qynat.qvtvafvgr.pbz>
 <BAYC1-PASMTP04A6968C3ABEA48C9AD2E5AE200@CEZ.ICE> 
 <20060921182554.23044ca3.seanlkml@sympatico.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, Sean wrote:

>> also people could be behind a firewall that prevents git from working properly,
>> for them tarballs and patches are the right way of doing things.
>
> I use git from behind a firewall everyday without a problem.  If you've seen
> such a problem yourself, a bug report would hopefully lead to a solution.

it's not a bug, it's simply the fact that git (properly) uses it's own port for 
it's own protocol, and not all firewalls allow access to that port. in some 
cases even where a person would have the ability to get the firewall changed 
they may not want to for other (political) reasons.

even if git tunneled over HTTP there would be firewalls that would require 
authentication that git wouldn't be able to do and would therefor block the 
access.

David Lang
