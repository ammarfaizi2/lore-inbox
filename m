Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131490AbRBASpB>; Thu, 1 Feb 2001 13:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130264AbRBASon>; Thu, 1 Feb 2001 13:44:43 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:17694 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S130866AbRBASo2>; Thu, 1 Feb 2001 13:44:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14969.44679.112479.385009@somanetworks.com>
Date: Thu, 1 Feb 2001 13:44:23 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: hiren_mehta@agilent.com
CC: linux-kernel@vger.kernel.org
Subject: Re: problem with devfsd compilation
In-Reply-To: <FEEBE78C8360D411ACFD00D0B747797188097A@xsj02.sjs.agilent.com>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B747797188097A@xsj02.sjs.agilent.com>
X-Mailer: VM 6.75 under 21.2  (beta40) "Persephone" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "hm" == hiren mehta <hiren_mehta@agilent.com> writes:

 hm> Hi, I am trying to compile devfsd on my system running RedHat
 hm> linux 7.0 (kernel 2.2.16-22). I get the error "RTLD_NEXT"
 hm> undefined. I am not sure where this symbol is defined. Is there
 hm> anything that I am missing on my system.

make CEXTRAS=-D_GNU_SOURCE

is one way to get around this.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
