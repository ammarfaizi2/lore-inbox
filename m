Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313297AbSDERXj>; Fri, 5 Apr 2002 12:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313313AbSDERX3>; Fri, 5 Apr 2002 12:23:29 -0500
Received: from www.transvirtual.com ([206.14.214.140]:53776 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S313297AbSDERXS>; Fri, 5 Apr 2002 12:23:18 -0500
Date: Fri, 5 Apr 2002 09:23:11 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Superfluous videomode reload during VT switch
In-Reply-To: <20020404192515.GA31252@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.10.10204050922220.21397-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When I switch between the consoles the monitor picture gets 1/3 of its width
> and slowly ramps up to normal size during next 400ms. It is obviously weird
> because framebuffer uses the same video mode on all consoles so that there
> is no point is resetting it again and again when it is the same mode.

I agree. The framebuffer layer is going to be changing very soon so this
will be fixed :-)

