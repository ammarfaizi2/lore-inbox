Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292933AbSB0Wor>; Wed, 27 Feb 2002 17:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293025AbSB0WoW>; Wed, 27 Feb 2002 17:44:22 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:41741 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293009AbSB0WoG>;
	Wed, 27 Feb 2002 17:44:06 -0500
Date: Wed, 27 Feb 2002 14:37:31 -0800
From: Greg KH <greg@kroah.com>
To: Allo! Allo! <lachinois@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel module ethics.
Message-ID: <20020227223731.GB7760@kroah.com>
In-Reply-To: <F82zxvoEaZWNaBJjvmZ00001183@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F82zxvoEaZWNaBJjvmZ00001183@hotmail.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 30 Jan 2002 20:00:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 04:11:38PM -0500, Allo! Allo! wrote:
> 
> The hardware needs a firmware to run. Since this firmware is under NDA, the 
> first compromise is to write the main part of the driver GPL but keep the 
> firmware of the card in binary format. The driver can then load the 
> firmware separately and this should not infringe on the GPL and I'm quite 
> ok with this requirement. Now the problem is that any of our competitor's 
> cards will work with the same closed sourced firmware and GPL engine. In 
> pure capitalist thinking, the company finds this particularly troublesome...

There are already a number of drivers that do just this (download closed
source firmware into a device, with a open source driver), so this is
probably the best thing to do.

Now the fact that your firmware will run on other company's cards means
that you need to modify your hardware so that this is not possible :)

Good luck,

greg k-h
