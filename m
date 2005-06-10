Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVFJMZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVFJMZm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 08:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVFJMZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 08:25:42 -0400
Received: from smtp803.mail.ukl.yahoo.com ([217.12.12.140]:57220 "HELO
	smtp803.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262371AbVFJMZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 08:25:34 -0400
Message-ID: <42A994A6.7000104@unixtrix.com>
Date: Fri, 10 Jun 2005 13:24:54 +0000
From: Alastair Poole <alastair@unixtrix.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: BUG: Unusual TCP Connect() results.
References: <42A8ABDB.6080804@unixtrix.com> <A0454426-3FE0-42F4-BA87-8B0BE18DFEAC@mac.com>
In-Reply-To: <A0454426-3FE0-42F4-BA87-8B0BE18DFEAC@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> SSH and 3 RPC-based services, I would guess.  This is not a kernel
> bug, there are probably userspace applications which are opening
> those ports, even something as simple as an FTP client in active
> mode would do it.  Please run "netstat -lp" to determine which 
> processes have opened each port.

 >> These ports are definately not opened, yet still connect() returns 0 
with new kernels for ports
 >> that it should not.  I should have been more specific with nmap; 
even when specifying port ranges
 >> nmap still does not return these odd results upon a basic tcp scan.  
Only basic scanner like the ones
 >> mentioned and included in the first post.  No other RPC services or 
TCP daemons are running
 >> these are definately rogue ports.  Running on x86 and kernels 
2.6.11.10, 2.6.11.11 and 2.6.12-rc6
 >> the unusual results still persist when using these basic port 
scanners upon localhost.  I have someone
 >> else who has confirmed to me the same results.  Can anyone here?
