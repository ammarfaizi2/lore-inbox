Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbSJDNer>; Fri, 4 Oct 2002 09:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261666AbSJDNer>; Fri, 4 Oct 2002 09:34:47 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:10192 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261616AbSJDNeq>; Fri, 4 Oct 2002 09:34:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
Date: Fri, 4 Oct 2002 08:07:19 -0500
X-Mailer: KMail [version 1.2]
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       evms-devel@lists.sourceforge.net
References: <02100216332002.18102@boiler> <02100319394801.00236@cygnus> <1033736789.31839.24.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1033736789.31839.24.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Message-Id: <02100408071900.02266@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 08:06, Alan Cox wrote:
> On Fri, 2002-10-04 at 01:39, Kevin Corry wrote:
> > Yep, you guessed it. I'm no big fan of Lindent. In my opinion, it makes
> > some really bad choices about how to break long lines (among other
> > things), as you've kindly pointed out. But, I had to start somewhere and
> > wanted to get something out before I left for the day. Obviously the AIX
> > plugin will need some additional attention at some point.
>
> IMHO the Lindent script is broken. It should also specify a line length
> of something like 256 so it doesnt go mashing lines.

Well, currently the Lindent script specifies a line length of 80 characters. 
Should this be changed?

indent -kr -i8 -ts8 -sob -l80 -ss -bs -psl "$@"
                         ^^^^

The CodingStyle document doesn't seem to specifically mention line length, 
but does imply in a couple of places that code should fit nicely on a 
80-column, 24/25-line terminal.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
