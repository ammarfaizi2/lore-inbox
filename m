Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279927AbRJ3L5o>; Tue, 30 Oct 2001 06:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279931AbRJ3L5e>; Tue, 30 Oct 2001 06:57:34 -0500
Received: from flaske.stud.ntnu.no ([129.241.56.72]:16789 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S279927AbRJ3L5Y>; Tue, 30 Oct 2001 06:57:24 -0500
Date: Tue, 30 Oct 2001 12:57:20 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Johan <jo_ni@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still having problems with eepro100
Message-ID: <20011030125720.A469@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com>; from jo_ni@telia.com on Tue, Oct 30, 2001 at 12:39:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan:
> Does anyone except me still having problems with the eepro100 drivers ?

Yes, as I've mentioned in a earlier thread on this list, we have problems,
but trying the e100-driver from intel doesn't seem to help either (I'm
running tests now, and so far, they don't look very promising).

> The network connection stalls and I'll get this message:
> eepro100: wait_for_cmd_done timeout!

I'm experiensing the:
eth0: Card reports no resources

And, then a hang of at least a minute before the network connection is
restored. All my connections are 100Mbit full duplex, and the error comes
when doing heavy traffic. (Try bonnie++ over NFS, for instance).


-- 
Thomas
