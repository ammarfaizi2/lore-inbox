Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261820AbSIXVcb>; Tue, 24 Sep 2002 17:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbSIXVb2>; Tue, 24 Sep 2002 17:31:28 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:7167 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S261820AbSIXVah>; Tue, 24 Sep 2002 17:30:37 -0400
Message-ID: <3D90DAA5.7020304@nortelnetworks.com>
Date: Tue, 24 Sep 2002 17:35:33 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Christopher Friesen" <cfriesen@nortelnetworks.com>,
       David Schwartz <davids@webmaster.com>, pwaechtler@mac.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <Pine.LNX.4.44L.0209241822080.15154-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Tue, 24 Sep 2002, Chris Friesen wrote:

>>This is interesting--I hadn't considered this as most of my work for the
>>past while has been on embedded systems with everything pinned in ram.
>>
> 
> On an ftp server (or movie server, or ...) you CAN'T pin everything
> in RAM.

Yes, but you can use aio to issue the request for data and then go do 
other stuff even with a single thread.  David's case was faulting in 
little-used application code.

Or arm I missing something?

Chris

