Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbTDWROU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTDWROU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:14:20 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:8137 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263484AbTDWROT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:14:19 -0400
Message-ID: <3EA6947D.9080106@suwalski.net>
Date: Wed, 23 Apr 2003 09:26:21 -0400
From: Pat Suwalski <pat@suwalski.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030331
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423172120.GA12497@citd.de>
In-Reply-To: <20030423172120.GA12497@citd.de>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> I can only guess why. My buest guess is that not all
> sound-configurations are the same, on some systems the "defaults" could
> much to loud. (e.g. waking the neigbours when you restart you computer
> at night)

This is certainly the case. When I was packaging OSS for Xandros, our 
initial default was 50 percent. We eventualyl made it about 30, because 
even that was too loud on a laptop we were testing. There was little 
coherance between the various soundcards.

Waking the neighbors is the smallest problem. Blowing a speaker or 
makign the user deaf if quite another.

Yes, it's a distro problem. My Gentoo was build "-alsa" and so the 
alsa-sound init script does not 'go'. A simple rebuild will solve the 
problem.

--Pat

