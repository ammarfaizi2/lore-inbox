Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSLFPUc>; Fri, 6 Dec 2002 10:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbSLFPUc>; Fri, 6 Dec 2002 10:20:32 -0500
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:63420 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S263204AbSLFPUb>;
	Fri, 6 Dec 2002 10:20:31 -0500
Date: Fri, 6 Dec 2002 10:27:40 -0500
From: Mark Frazer <mark@somanetworks.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ipv4: how to choose src ip?
Message-ID: <20021206102740.A29099@somanetworks.com>
References: <20021205190054.GE23877@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021205190054.GE23877@louise.pinerecords.com>; from szepe@pinerecords.com on Thu, Dec 05, 2002 at 08:00:54PM +0100
X-Message-Flag: Outlook not so good.
Organization: Detectable, well, not really
X-Fry: How can I live my life if I can't tell good from evil?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe <szepe@pinerecords.com> [02/12/05 14:08]:
> 
> What I'm looking for is rather a way to
> initiate two connections to the same destination host using the two
> different source IP addresses.

I believe you can just bind(2) each socket to a different address
before connect(2).


-- 
Fry, of all the friends I've had ... you're the first. - Bender
