Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136647AbREJN7p>; Thu, 10 May 2001 09:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136663AbREJN7f>; Thu, 10 May 2001 09:59:35 -0400
Received: from zeus.kernel.org ([209.10.41.242]:54674 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136616AbREJN7P>;
	Thu, 10 May 2001 09:59:15 -0400
Date: Wed, 9 May 2001 20:32:59 -0700
From: Greg KH <greg@kroah.com>
To: clameter@lameter.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB broken in 2.4.4? Serial Ricochet works, USB performance sucks.
Message-ID: <20010509203259.B4685@kroah.com>
In-Reply-To: <Pine.LNX.4.10.10105091739490.22715-100000@melchi.fuller.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10105091739490.22715-100000@melchi.fuller.edu>; from clameter@lameter.com on Wed, May 09, 2001 at 05:52:04PM -0700
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 05:52:04PM -0700, clameter@lameter.com wrote:
> I recently got a ricochet 128k GS wireless modem and I am running it with
> kernel 2.4.4 and ppp 2.4.1.
> 
> Using the USB connection (configured to operatate at 460kbit)  I get up to
> 2kbyte per second. With serial(at 115kbit) this goes up to 8kbyte per
> second.
> 
> Why is this?

Because currently the USB acm driver is not tuned for speed, reliability
up to now has been more important :)

greg k-h
