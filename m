Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270661AbRIFNX7>; Thu, 6 Sep 2001 09:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270712AbRIFNXt>; Thu, 6 Sep 2001 09:23:49 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:44464 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S270661AbRIFNXk>;
	Thu, 6 Sep 2001 09:23:40 -0400
Date: Thu, 06 Sep 2001 14:23:58 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>,
        Daniel Phillips <phillips@bonn-fries.net>
Cc: riel@conectiva.com.br, jaharkes@cs.cmu.edu, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <592148204.999786238@[10.132.112.53]>
In-Reply-To: <20010906151015.69d2afb2.skraw@ithnet.com>
In-Reply-To: <20010906151015.69d2afb2.skraw@ithnet.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, September 06, 2001 3:10 PM +0200 Stephan von Krawczynski 
<skraw@ithnet.com> wrote:

> Obviously aging did not work at all,
> there was not a single hit on these (CD image) pages during 24 hours,
> compared to lots on the nfs-data.

If there's no memory pressure, data stays in InactiveDirty, caches,
etc., forever. What makes you think more memory would have helped
the NFS performance? It's possible these all were served out of caches
too.

--
Alex Bligh
