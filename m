Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264933AbUEVLmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUEVLmM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 07:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUEVLmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 07:42:12 -0400
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:62453 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S264933AbUEVLmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 07:42:10 -0400
Date: Sat, 22 May 2004 13:42:04 +0200
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] [usb] bad: scheduling while atomic!
Message-ID: <20040522114204.GA25141@sun1000.pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
References: <20040521224531.GA15538@sun1000.pwr.wroc.pl> <20040521235229.GB13404@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040521235229.GB13404@kroah.com>
X-Useless-Header: Vim powered ;^)
X-00-Privacy-Policy: S/MIME encrypted e-mail is welcome.
X-04-Privacy-Policy-My_SSL_Certificate: http://www.europki.pl/cgi-bin/dn-cert.pl?serial=000001D2&certdir=/usr/local/cafe/data/polish_ca/certs/user&type=email
X-05-Privacy-Policy-CA_SSL_Certificate: http://www.europki.pl/polish_ca/ca_cert/en_index.html
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On pi±, 21 maj 2004 at 04:52:29  -0700, Greg KH wrote:
> On Sat, May 22, 2004 at 12:45:31AM +0200, Pawel Dziekonski wrote:
> > Hi,
> > 
> > vanilla 2.6.6, I'm trying to rmmod my adsl usb modem module.
> > rmmod hangs. I can Control-C it, but is does not end - it takes 
> > 100% of cpu.
> 
> That's not "vanilla" as that kernel does not have a eagle-usb driver in
> it, right?  Try talking with the authors of that driver please about
> fixing this problem.

yes, you are right, this is an external driver.
I have written to linux kernel, because I had massive problems with this
modem with many kernel versions, including 2.4. for example, load of
sound modules was  freezing network connection. 2.6.6 changed this to
more stable situation and now the only problem is what I have described.
that's why I think it's rather kernel problem.
this is nforce2 based system.

regards, Pawel

-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy and S/MIME info.
