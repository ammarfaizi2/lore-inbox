Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBNGcp>; Wed, 14 Feb 2001 01:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129108AbRBNGcf>; Wed, 14 Feb 2001 01:32:35 -0500
Received: from npt12056206.cts.com ([216.120.56.206]:65037 "HELO
	forty.spoke.nols.com") by vger.kernel.org with SMTP
	id <S129027AbRBNGcT>; Wed, 14 Feb 2001 01:32:19 -0500
Date: Tue, 13 Feb 2001 22:32:14 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] zerocopy patch against 2.4.2-pre2
Message-ID: <20010213223214.A9204@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A868FF3.BC7F6679@uow.edu.au>, <14979.43130.731593.90703@pizda.ninka.net> <3A868FF3.BC7F6679@uow.edu.au> <14984.55981.974147.573306@pizda.ninka.net> <3A89362E.A0DE6C14@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A89362E.A0DE6C14@uow.edu.au>; from andrewm@uow.edu.au on Wed, Feb 14, 2001 at 12:27:10AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2001 at 12:27:10AM +1100, Andrew Morton wrote:
> 
> It's getting very lonely testing this stuff. It would be useful if
> someone else could help out - at least running the bw_tcp tests. It's
> pretty simple:
> 
> 	bw_tcp -s ; bw_tcp 0

OK, here's my bw_tcp results on a K6-2 450. I ran bw_tcp 10 times, then
averaged the results.

                bw_tcp
2.4.2-pre3       57.0
2.4.2-pre3zc     52.6

-Dave
