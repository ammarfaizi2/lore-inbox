Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWA0VXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWA0VXg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 16:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWA0VXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 16:23:36 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:41229 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1751441AbWA0VXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 16:23:35 -0500
Message-ID: <43DA8F4F.50000@symas.com>
Date: Fri, 27 Jan 2006 13:23:27 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: davids@webmaster.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKMEHJJLAB.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEHJJLAB.davids@webmaster.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 	After collecting other opinions from comp.programming.threads, and being
> unable to find other people who considered it reasonable, I've changed my
> opinion. I was far too generous and deferential before.
>   

David, you specifically have been faced with this question before:
http://groups.google.com/group/comp.programming.threads/browse_frm/thread/2184ba84f911d9dd/a6e4f7cf13bbec2d#a6e4f7cf13bbec2d
and you didn't dispute the interpretation then. The wording for 
pthread_mutex_unlock hasn't changed between 2001 and now.

And here:
http://groups.google.com/group/comp.programming.threads/msg/89cc5d600e34e88a?hl=en&

If those statements were incorrect, I have a feeling someone would have 
corrected them at the time. Certainly you can attest to that.
http://groups.google.com/group/comp.programming.threads/msg/d5b2231ca57bb102?hl=en&

Clearly at this point there's nothing to be gained from pursuing this 
any further. The 2.6 kernel has been out for too long; if it were to be 
"fixed" again it would just make life ugly for another group of people, 
and I don't want to write the autoconf tests to detect the 
flavor-of-the-week. We've wasted enough time arguing futilely over it, 
I'll stop.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

