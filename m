Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285401AbRLSRDy>; Wed, 19 Dec 2001 12:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285402AbRLSRDn>; Wed, 19 Dec 2001 12:03:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46809 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285401AbRLSRD2>;
	Wed, 19 Dec 2001 12:03:28 -0500
Date: Wed, 19 Dec 2001 12:03:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <m14rmnw6p3.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.4.21.0112191153280.11104-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 19 Dec 2001, Eric W. Biederman wrote:

> I have alarm bells ringing in my gut saying there are pieces of your
> proposal that are on the edge of being overly complex... But without
> source I can't really say.  Arbitrary NULL padding between images is
> cool but why?

	Alignment that might be wanted by loaders.  Take that with hpa - for
all I care it's a non-issue.  while(!*p) p++; added before p = handle_part(p);
in the main loop...

