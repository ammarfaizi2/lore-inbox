Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290725AbSARPxM>; Fri, 18 Jan 2002 10:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290726AbSARPxC>; Fri, 18 Jan 2002 10:53:02 -0500
Received: from [66.189.64.253] ([66.189.64.253]:19333 "HELO majere.epithna.com")
	by vger.kernel.org with SMTP id <S290725AbSARPwt>;
	Fri, 18 Jan 2002 10:52:49 -0500
Date: Fri, 18 Jan 2002 10:52:16 -0500 (EST)
From: <listmail@majere.epithna.com>
To: Tommy Faasen <faasen@xs4all.nl>
Cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: vm philosophising
In-Reply-To: <20020118154239.A11920@xs4all.nl>
Message-ID: <Pine.LNX.4.33.0201181041440.28887-100000@majere.epithna.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Jan 2002, Tommy Faasen wrote:


> I have no clue about VM's but I can imagine that for example the following situations have different requirements:
> 1-Desktop: many "small" apps, I believe exe's remain in memory and data is written to disk? Anyway I can imagine fragmentation and latency is an issue here.
> 2-DBMS: 1 or 2 big programs which sometimes even do their own memory management.Fragmentation and latency isn't issue here I think however moving ltos of data to and from swap is.
> 3-Webserver: for example apache with many childs being created under high load and killed under low load. The data is always small (in case of static pages). So a lot of small swaps? Latency is not as much as un issue but I can imagine that fragmentation can be an issue?

There is another situation to consider which I think more typical in the
"Real World"

4 - The Typical Web server Environment, in many many companies that I have
seen.
  The machine runs both the DBMS(mysql, Oracle, etc) and the web server
Apache.  Therefore a balence of memory use needs to be struck between the
two applications.  Then ususally the system also has a development
environment at the ready incase changes need to be made quickly from the
console.  While this may not be true as things scale up for a business and
functions get separated to different machines.  Many startups and small
businesses that I have worked with that have turned to LINUX for the OS
becuase the TCO, it offers over the other guys, tend to have just that
single does everything box.

-Bill

