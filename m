Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbUADACH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbUADACH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:02:07 -0500
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:62849 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S264340AbUADACF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:02:05 -0500
Date: Sun, 4 Jan 2004 01:02:01 +0100
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: szonyi calin <caszonyi@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE performance drop between 2.4.23 and 2.6.0 - pinpointed!
Message-ID: <20040104000200.GA2594@sun1000.pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
References: <20040103220159.GA22096@sun1000.pwr.wroc.pl> <20040103224636.5738.qmail@web40602.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040103224636.5738.qmail@web40602.mail.yahoo.com>
X-Useless-Header: Vim powered ;^)
X-00-Privacy-Policy: OpenPGP or S/MIME encrypted e-mail is welcome.
X-01-Privacy-Policy-GPG-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?search=dzieko@pwr.wroc.pl&op=get
X-02-Privacy-Policy-GPG-Key_ID: 5AA7253D
X-03-Privacy-Policy-GPG-Key_fingerprint: A80B 5022 185B 1BB5 8848  74C4 A7E1 423C 5AA7 253D
X-04-Privacy-Policy-Personal_SSL_Certificate: http://www.europki.pl/cgi-bin/dn-cert.pl?serial=000001D2&certdir=/usr/local/cafe/data/polish_ca/certs/user&type=email
X-05-Privacy-Policy-CA_SSL_Certificate: http://www.europki.pl/polish_ca/ca_cert/en_index.html
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On sob, 03 sty 2004 at 11:46:36  +0100, szonyi calin wrote:
>  --- Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl> a écrit : >
> hi,
> > 
> > same problem here however it seems that i have pinpointed it
> > )at least
> > for me):
> > 

> from the manpage of hdparm: -t     Perform timings of device reads for
> benchmark and compari- son  purposes.   For  meaningful  results,
> this operation should be repeated 2-3 times on an otherwise inactive
> sys- tem  (no  other active processes) with at least a couple of
> megabytes of free memory. 

> if the above conditions are not met your test is irrelevant 

those conditions were met. trust me  - i have just copied and pasted some
of the results :^)

ps. btw, for last 5 years 2.6.0 this is a 1st example of a situation
where hdparm gives me so unstable results. i think this is because of
the nature of as-scheduler. maybe i'm wrong.

-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy info.
