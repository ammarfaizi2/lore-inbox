Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131344AbRDIAQU>; Sun, 8 Apr 2001 20:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131308AbRDIAQM>; Sun, 8 Apr 2001 20:16:12 -0400
Received: from ns.suse.de ([213.95.15.193]:30482 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131323AbRDIAQB>;
	Sun, 8 Apr 2001 20:16:01 -0400
Date: Mon, 9 Apr 2001 02:15:51 +0200
From: Andi Kleen <ak@suse.de>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sources of entropy - /dev/random problem for network servers
Message-ID: <20010409021551.B17466@gruyere.muc.suse.de>
In-Reply-To: <1457842476.986773581@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1457842476.986773581@[195.224.237.69]>; from linux-kernel@alex.org.uk on Sun, Apr 08, 2001 at 11:46:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2001 at 11:46:21PM +0100, Alex Bligh - linux-kernel wrote:
> The following patch fixes eepro100.c - others can be
> patched similarly.

Problem is that it allows someone with sniffer access to your network to
make a pretty good estimate of your random pool. If you search the archives
there was a big discussion about it some months ago. Currently there is no
good solution, except for using add-on hardware that offers randomness 
(that can be as simple as a spare sound card with some noise input) 

-Andi
