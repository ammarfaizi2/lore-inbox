Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129753AbRB0K7F>; Tue, 27 Feb 2001 05:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129766AbRB0K6z>; Tue, 27 Feb 2001 05:58:55 -0500
Received: from 25dyn119.com21.casema.net ([213.17.95.119]:12306 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129753AbRB0K6l>;
	Tue, 27 Feb 2001 05:58:41 -0500
Date: Tue, 27 Feb 2001 11:58:29 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
Message-ID: <20010227115829.A6166@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200102271002.f1RA2B408058@brick.arm.linux.org.uk> <20010227111839.F2736@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <20010227111839.F2736@jaquet.dk>; from rasmus@jaquet.dk on Tue, Feb 27, 2001 at 11:18:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 11:18:39AM +0100, Rasmus Andersen wrote:

> terminate, apparently because the child does not receive the KILLUSR1
> (wild speculation)? Anyways, the parent process waits in wait4 and
> the child loops, waiting for the signal. This is not reproducable
> in 2.2.X (for me).

rsync problems of this type abound across several UNIX platforms - I had
problems like this on FreeBSD, but never under Linux. I suspect that rsync
bends or at least stretches certain limits.

Regards,

bert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
