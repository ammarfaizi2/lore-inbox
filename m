Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266235AbTIKHfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 03:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbTIKHfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 03:35:41 -0400
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:14493 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S266235AbTIKHfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 03:35:37 -0400
Date: Thu, 11 Sep 2003 09:35:34 +0200
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-ac1 -- fh_verify: no root_squashed access at ...
Message-ID: <20030911073534.GA5534@pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi,

instantly after switching from 2.4.21-pre6 to 2.4.22-ac1 I get loads of
that in logs:

fh_verify: no root_squashed access at my-dir

where my-dir is a subdirectory of parent which is exported to
several machines, and is also remounted locally for some reason ;-)

what has changed?
thanks in advence, Pawel
-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy info.
