Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132690AbRDQUue>; Tue, 17 Apr 2001 16:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132859AbRDQUuX>; Tue, 17 Apr 2001 16:50:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16521 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132690AbRDQUuG>;
	Tue, 17 Apr 2001 16:50:06 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15068.44155.12096.565071@pizda.ninka.net>
Date: Tue, 17 Apr 2001 13:50:03 -0700 (PDT)
To: Jesse S Sipprell <jss@inflicted.net>
Cc: Jan Kasprzak <kas@informatics.muni.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
In-Reply-To: <20010417164407.B21620@bastard.inflicted.net>
In-Reply-To: <20010417170206.C2589096@informatics.muni.cz>
	<E14pXxg-0002cI-00@the-village.bc.nu>
	<20010417181524.E2589096@informatics.muni.cz>
	<20010417161036.A21620@bastard.inflicted.net>
	<15068.42539.768756.883953@pizda.ninka.net>
	<20010417164407.B21620@bastard.inflicted.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jesse S Sipprell writes:
 > On error, -1 is returned in the usual fashion and offset is purported to be
 > updated to point to the next byte following the last one sent.
 > 
 > Will the zerocopy patches break this?

No, they should not.

Later,
David S. Miller
davem@redhat.com
