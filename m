Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289783AbSBOVhL>; Fri, 15 Feb 2002 16:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289768AbSBOVhB>; Fri, 15 Feb 2002 16:37:01 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:50670 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S292158AbSBOVgt>; Fri, 15 Feb 2002 16:36:49 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E16bo2F-0000iJ-00@aemiaif.lip6.fr> 
In-Reply-To: <E16bo2F-0000iJ-00@aemiaif.lip6.fr> 
To: Willy TARREAU <tarreau@aemiaif.lip6.fr>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, willy@meta-x.org,
        esr@thyrsus.com
Subject: Re: [SUCCESS] Linux 2.4.18-rc1 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Feb 2002 21:36:13 +0000
Message-ID: <3132.1013808973@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


tarreau@aemiaif.lip6.fr said:
>  I also attach the .config used. To resume it, there are :
>   - 526 options set to "y"
>   - 831 options set to "m"
>   - 81 options not set (arch dependant...) 

Cute. Eric - can you confirm that if you drop this .config in place with 
CML2 and run 'make oldconfig', nothing gets changed? Or at least justify 
individually any changes which _do_ happen.

In fact, a useful test suite would be to make randomconfig, then oldconfig 
with CML2 and CML1, verifying that there are no changes. 

--
dwmw2


