Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUBFVOy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbUBFVOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:14:32 -0500
Received: from 213-176-151-74.in.is ([213.176.151.74]:34195 "EHLO
	schpilkas.net") by vger.kernel.org with ESMTP id S266544AbUBFVNy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:13:54 -0500
Message-ID: <40240391.7030209@hi.is>
Date: Fri, 06 Feb 2004 21:13:53 +0000
From: Gunnlaugur Thor Briem <gthb@hi.is>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040130 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gunnlaugur Thor Briem <gthb@hi.is>
CC: Daniel Brahneborg <daniel.com@wtnord.net>, Jeff Garzik <jgarzik@pobox.com>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Status of Promise drivers?
References: <20031230200012.C14399@nettis.grimsta> <3FF1CCC1.3050304@pobox.com> <20040203192336.A5570@nettis.grimsta> <4021099A.6090209@hi.is>
In-Reply-To: <4021099A.6090209@hi.is>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunnlaugur Thor Briem wrote:
 > http://bugzilla.kernel.org/show_bug.cgi?id=2011
[...]
 > Don't know about any other motherboards, but in any case your kernel is
 > likely to hang when trying to use a PDC 20376 (on a motherboard, as in
 > my case, or on a separate board), for the time being.

... and now he corrects himself. I just tried applying Ross Dickson's 
patches for APIC quirks on nForce2 chipsets:

http://lkml.org/lkml/2003/12/21/7

and that seems to have taken care of my problem completely. I have not 
tested for very long, but I got through the bonnie++ test suite; never even 
came close before.

So the Promise controller and driver appear to be innocent of my woes, and I 
do not know any reason to think that your kernel will hang because of them.

Sorry 'bout that. (And thanks Ross!)

     - Gulli
