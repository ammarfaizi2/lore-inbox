Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271503AbRIAXyl>; Sat, 1 Sep 2001 19:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271502AbRIAXya>; Sat, 1 Sep 2001 19:54:30 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:21778 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S271487AbRIAXyT>;
	Sat, 1 Sep 2001 19:54:19 -0400
Date: Sun, 2 Sep 2001 09:49:11 +1000
From: Anton Blanchard <anton@samba.org>
To: Tom Gall <tom_gall@vnet.ibm.com>
Cc: Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: is bzImage container large enough?
Message-ID: <20010902094911.A6041@krispykreme>
In-Reply-To: <22500.999376181@ocs3.ocs-net> <3B914805.F9883E5E@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B914805.F9883E5E@vnet.ibm.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The bug we fixed was that an uncompressed
> kernel could only be up to 4 meg in size, if it was larger, at
> uncompression time you'd just lose everything past the 4M mark.
> Todd Inglett raised the limit to 8 meg for us, and that's a mighty
> large penguin....

Computing the size at link time is neater and this is what he actually
does.

Anton
