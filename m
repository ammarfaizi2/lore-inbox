Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318040AbSIETnw>; Thu, 5 Sep 2002 15:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318059AbSIETnw>; Thu, 5 Sep 2002 15:43:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:51446 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318040AbSIETnu>; Thu, 5 Sep 2002 15:43:50 -0400
Message-ID: <3D77B38D.2090402@watson.ibm.com>
Date: Thu, 05 Sep 2002 15:42:05 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-aio@kvack.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: libaio 0.3.90 -- test release for sync up
References: <20020905011755.A7979@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

Any updates on when we can see some more "core" aio code for 2.5 ?

Is the code you've been developing substantially the same as in 2.4 ?
 From a brief examination of the 2.4 aio code for raw I/O, it doesn't 
look like it'll need a whole lot of changes except to use bio's. Or do 
you have a different design in place now ?

Any comments/dates will be much appreciated....

- Shailabh

Benjamin LaHaise wrote:
> Hello,
> 
> Well, Andrea seems to be trying to fork libaio, but he never sent 
> any patches to me, so I don't know what his complaint with me as 
> maintainer is.  I hope he finds it in his heart to submit *patches* 
> for any changes he's making.  Anyways, here's a test release going 
> in the direction I've meant to for libaio-0.4.0 -- 0.3.15 is a 
> compatible release for folks running Red Hat Advanced Server and 
> does not break source/binary compatibility.  0.4.0 on the other 
> hand breaks source compatibility to match the changes made for 2.5, 
> but should still provide backwards compatible symbols.  I've also 
> tossed the beginnings of man pages in man/ for people to hack on 
> (Alan, Bert you guys need to synch up with each other on list).  
> ChangeLog bits are below, the test cases have not been updated for 
> the new API, nor has it been tested in any way mean or form.  I'll 
> try to get a 0.3.91 out before I leave tomorrow afternoon, but if 
> not it will wait until Tuesday.
> 
> 		-ben



