Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268028AbTAIWIr>; Thu, 9 Jan 2003 17:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268031AbTAIWIr>; Thu, 9 Jan 2003 17:08:47 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:36081 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S268028AbTAIWIp>; Thu, 9 Jan 2003 17:08:45 -0500
Date: Thu, 9 Jan 2003 17:17:28 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Adam Voigt <adam@cryptocomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High FS Activity Crash
Message-ID: <20030109171728.K26340@redhat.com>
References: <1041860708.13245.7.camel@beowulf.cryptocomm.com> <1041861020.13159.11.camel@beowulf.cryptocomm.com> <1041861227.13245.14.camel@beowulf.cryptocomm.com> <1041861823.13159.21.camel@beowulf.cryptocomm.com> <1041861941.13245.26.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1041861941.13245.26.camel@beowulf.cryptocomm.com>; from adam@cryptocomm.com on Mon, Jan 06, 2003 at 09:05:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 09:05:40AM -0500, Adam Voigt wrote:
> Ok, on my fileserver I'm running Redhat 7.2 with Redhat kernel 2.4.7-10 
> and when I have a large number of people downloading from me at one
> time, Samba, ProFTPD, Apache, and SSH all stop responding, and I get the
> following in my log, the only thing special I could think about my setup
> is I have 3 NIC's bonded together to be load balanced on the same IP,
> any ideas? 

That looks like a vm bug that was fixed around the 2.4.9-31 timeframe.  You 
really should be using the latest errata kernel that Red Hat has released, 
as many bugs have been fixed since 2.4.7-10.

		-ben
