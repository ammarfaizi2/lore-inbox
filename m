Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291243AbSBGTvz>; Thu, 7 Feb 2002 14:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291245AbSBGTvp>; Thu, 7 Feb 2002 14:51:45 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:6335 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S291243AbSBGTv0>; Thu, 7 Feb 2002 14:51:26 -0500
Date: Thu, 7 Feb 2002 14:51:18 -0500
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: want opinions on possible glitch in 2.4 network error reporti ng
Message-ID: <20020207195118.GB31329@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Chris Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020207125644.8721A-100000@chaos.analogic.com> <3C62CB25.75487AD5@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C62CB25.75487AD5@nortelnetworks.com>
User-Agent: Mutt/1.3.27i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 01:44:53PM -0500, Chris Friesen wrote:
> The possibility of random dropping of packets in the kernel means that an
> infinite loop on sendto() will chew up the entire machine even if you've only
> got a 10Mbit/s link.  This seems just wrong.

What happens if you have the 100Mbit/s side of the link and the receiver
has a 9600baud dial-in modem....

The sending side needs to do throttling based on packet loss anyways, it
really doesn't matter that it's lost locally or on the network or at the
receiving host.

Jan

