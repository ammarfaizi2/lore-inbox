Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbRAYJtw>; Thu, 25 Jan 2001 04:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbRAYJtm>; Thu, 25 Jan 2001 04:49:42 -0500
Received: from 3dyn148.com21.casema.net ([212.64.94.148]:27914 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S130188AbRAYJti>;
	Thu, 25 Jan 2001 04:49:38 -0500
Date: Thu, 25 Jan 2001 11:42:01 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010125114201.A32526@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E14LawQ-000893-00@the-village.bc.nu> <Pine.SOL.4.21.0101250905140.15936-100000@orange.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <Pine.SOL.4.21.0101250905140.15936-100000@orange.csi.cam.ac.uk>; from jas88@cam.ac.uk on Thu, Jan 25, 2001 at 09:06:33AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 09:06:33AM +0000, James Sutherland wrote:

> performance than it would for an httpd, because of the long-lived
> sessions, but rewriting it as a state machine (no forking, threads or
> other crap, just use non-blocking I/O) would probably make much more
> sense.

>From a kernel coders perspective, possibly. But a lot of SMB details are
pretty convoluted. Statemachines may produce more efficient code but can be
hell to maintain and expand. Bugs can hide in lots of corners.

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
