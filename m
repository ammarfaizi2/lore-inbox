Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132607AbRDBC5R>; Sun, 1 Apr 2001 22:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132608AbRDBC5H>; Sun, 1 Apr 2001 22:57:07 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:8454 "HELO
	mail11.speakeasy.net") by vger.kernel.org with SMTP
	id <S132607AbRDBC4z>; Sun, 1 Apr 2001 22:56:55 -0400
Message-ID: <3AC7DC85.CED53440@megapathdsl.net>
Date: Sun, 01 Apr 2001 18:57:25 -0700
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac28 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <dlang@diginsite.com>
CC: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.4.33.0104011415320.25794-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> 
> On Sun, 1 Apr 2001, Larry McVoy wrote:
> 
> when generating the auto bug reports make sure that the system tells the
> user exactly what data is being sent.
> 
> sending a large chunk of unknown data off the machine is a big concern to
> many people.

Yeah.  This is a good point, although I can't think of info
about a system's hardware and software configuration that would
be particularly sensitive, other than files that contain network
topology or encrypted passwords.  I'm sure others can come up
with such a list.  One candidate might be the smbfs configuration
file, since network passwords can live there, right?  tcpdump output
might also be sensitive, but that type of info would need to get 
requested by network driver developers after the initial bug report 
anyhow.  

	Miles
