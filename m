Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbUBXCUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 21:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbUBXCUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 21:20:09 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:57055 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262092AbUBXCUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 21:20:04 -0500
Message-ID: <403AB48E.2040800@us.ibm.com>
Date: Mon, 23 Feb 2004 18:18:54 -0800
From: Mike Christie <mikenc@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Thornber <thornber@redhat.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/6] dm: endio method
References: <20040220153145.GN27549@reti> <20040220153403.GO27549@reti> <40372BCE.7090708@us.ibm.com> <20040223100512.GB943@reti> <403A79E0.6080609@us.ibm.com> <20040223222928.GB14731@reti>
In-Reply-To: <20040223222928.GB14731@reti>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber wrote:

> On Mon, Feb 23, 2004 at 02:08:32PM -0800, Mike Christie wrote:
> 
>>With this move if the path has to be activated first, will the daemon 
>>have to call some sort of ps_path_is_initialized() function before it 
>>calls generic_make_request?
> 
> 
> Yes, I am planning to add something like this.  Whether it needs to be
> per path, or we could get away per priority group is probably a
> question that you could answer better than me ?  Do we need a
> corresponding deactivate for some hardware ?

Sorry, I do not know for sure. All the HW we have will activate one 
group and deactivate the other in one command or automatically.

Mike
