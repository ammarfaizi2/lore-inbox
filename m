Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbTIBGV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 02:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263549AbTIBGVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 02:21:55 -0400
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:21632 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S263555AbTIBGVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 02:21:54 -0400
Date: Tue, 2 Sep 2003 08:19:59 +0200
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi <linux-acpi@intel.com>
Subject: Re: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup
Message-ID: <20030902061959.GA29263@pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
References: <7F740D512C7C1046AB53446D3720017304AEF1@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AEF1@scsmsx402.sc.intel.com>
X-Useless-Header: Vim powered ;^)
X-00-Privacy-Policy: OpenPGP or S/MIME encrypted e-mail is welcome.
X-01-Privacy-Policy-GPG-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?search=dzieko@pwr.wroc.pl&op=get
X-02-Privacy-Policy-GPG-Key_ID: 5AA7253D
X-03-Privacy-Policy-GPG-Key_fingerprint: A80B 5022 185B 1BB5 8848  74C4 A7E1 423C 5AA7 253D
X-04-Privacy-Policy-Personal_SSL_Certificate: http://www.europki.pl/cgi-bin/dn-cert.pl?serial=00000069&certdir=/usr/local/cafe/data/polish_ca/certs_31.12.2002/user&type=email
X-05-Privacy-Policy-CA_SSL_Certificate: http://www.europki.pl/polish_ca/ca_cert/en_index.html
User-Agent: Mutt/1.5.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On pon, 01 wrz 2003 at 07:07:32  -0700, Nakajima, Jun wrote:
> Can you try the following patch that I sent out the other day? I saw
> this message when I was debugging, and it's gone with the patch. I
> assume you have ACPI enabled.

I'm gonna try that tonight. And indeed, I had acpi enabled. Disabling it
"fixes" the problem immediately.
thanks, P

> > -----Original Message-----
> > From: Pawel Dziekonski [mailto:pawel.dziekonski@pwr.wroc.pl]
> > Sent: Monday, September 01, 2003 8:36 AM
> > To: linux-kernel@vger.kernel.org
> > Subject: Re: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup
> > 
> > On nie, 31 sie 2003 at 04:11:25  +0200, Pawel Dziekonski wrote:
> > > Hi,
> > >
> > > clean 2.4.22-ac1, load of usb-uhci.o locks my machine hard :-(
> > > it was working OK with 2.4.22-rc2-ac2! machine is on KT133 chipset.
> > > I cant use plain 2.4.22 because of trouble of compiling it with XFS
> > > support (unofficial patch has no .config entries).
> > 
> > update: i have compiled usbcore and usb-uhci into the kernel
> > and now it hangs with:
> > spurious 8259A interrupt: IRQ7
> > 
> > anybody?

-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy info.
