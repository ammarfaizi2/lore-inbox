Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbRHKNvc>; Sat, 11 Aug 2001 09:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267620AbRHKNvM>; Sat, 11 Aug 2001 09:51:12 -0400
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:12561 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267615AbRHKNvI>; Sat, 11 Aug 2001 09:51:08 -0400
Date: Sat, 11 Aug 2001 14:47:29 +0100
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writes to mounted devices containing file-systems.
Message-ID: <20010811144729.B31614@wyvern>
Reply-To: adrian.bridgett@iname.com
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1010810075750.10479A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1010810075750.10479A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.20i
From: Adrian Bridgett <adrian.bridgett@iname.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001 at 08:43:58 -0400 (+0000), Richard B. Johnson wrote:
> 
> Is it possible that Linux could decline to write to a device that
> contains mounted file-systems? OTW, don't allow raw writes to
> devices or partitions if they are mounted; writes could only
> be through the file-systems themselves.
[snip]

Personally I'd prefer AIX's approach - let the write through (if the user
wants to shoot themselves in the foot...), but report an error about it (to
syslog). 

Adrian

Email: adrian.bridgett@iname.com
Windows NT - Unix in beta-testing. GPG/PGP keys available on public key servers
Debian GNU/Linux  -*-  By professionals for professionals  -*-  www.debian.org
