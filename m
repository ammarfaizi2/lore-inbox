Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315811AbSEEBn2>; Sat, 4 May 2002 21:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315812AbSEEBn1>; Sat, 4 May 2002 21:43:27 -0400
Received: from ppp-RAS1-2-80.dialup.eol.ca ([64.56.225.80]:49792 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S315811AbSEEBn0>; Sat, 4 May 2002 21:43:26 -0400
Date: Sat, 4 May 2002 21:43:26 -0400
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: kHTTPd -- 403 Forbidden
Message-ID: <20020504214326.A1289@node0.opengeometry.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020504212335.A1018@node0.opengeometry.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 09:23:35PM -0400, William Park wrote:
> I am trying out khttpd (0.1.6, I think) in 2.4.18 kernel.  But, when I do
>     lynx http://localhost:8080/test.html
> all I get is
>     HTTP/1.0 403 Forbidden
> message.
> 
>     - all parameters in /proc/sys/net/khttpd/* are default (ie. server port
>       = 8080)
>     - I am not running any other web server, so client port (80) is
>       irrelevant
>     - 'test.html' do exist, and has permission 644
> 
> Have I missed something obvious?

Arrgh... I reloaded 'khttpd.o' module, and now it works.  Maybe it doesn't
like parameters being changed after it starts for the first time.

Sorry for the false alarm.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
8-CPU Cluster, Hosting, NAS, Linux, LaTeX, python, vim, mutt, tin
