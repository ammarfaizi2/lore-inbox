Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130791AbRCFAEW>; Mon, 5 Mar 2001 19:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbRCFAEM>; Mon, 5 Mar 2001 19:04:12 -0500
Received: from snoopy.apana.org.au ([202.12.87.129]:9477 "HELO
	snoopy.apana.org.au") by vger.kernel.org with SMTP
	id <S130791AbRCFAEG>; Mon, 5 Mar 2001 19:04:06 -0500
To: linux-kernel@vger.kernel.org
Subject: USAGI IPv6 patches
From: Brian May <bam@snoopy.apana.org.au>
X-Home-Page: http://snoopy.apana.org.au/~bam/
Date: 06 Mar 2001 11:03:51 +1100
Message-ID: <84snkrvk48.fsf@snoopy.apana.org.au>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wondered if there are any long term plans to merge the USAGI IPv6
kernel patches into Linux?

See <UTL:http://www.linux-ipv6.org/>

Background:

Currently, if my sources on debian-ipv6 are correct, it is not
possible to create a IPv6 server that is not broken, as getaddrinfo
returns both IPv4 and IPv6 addresses, but the bind operation will only
succeed on the IPv6 address. The suggested work around at the moment
is to ignore the error returned by bind, but I consider that to be
broken, because the error might be important.

The only solution we have all agreed to (so far) on debian-ipv6 is to
use the USAGI patches (which IIRC modify getaddr to return only IPv6
addresses in the above situation), however, other Debian developers
are reluctant to require anything that is "non-standard" in the main
kernel.

Hence my question...
-- 
Brian May <bam@snoopy.apana.org.au>
