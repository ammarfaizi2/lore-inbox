Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbUBPO62 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbUBPO62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 09:58:28 -0500
Received: from [67.105.178.133] ([67.105.178.133]:53925 "EHLO rttx.com")
	by vger.kernel.org with ESMTP id S265622AbUBPO6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 09:58:17 -0500
Message-ID: <4030DADD.1040104@rttx.com>
Date: Mon, 16 Feb 2004 09:59:41 -0500
From: Peter Grace <pgrace@rttx.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: POSSIBLE BUG:  netfilter/ip_conntrack_core
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -115.0 (---------------------------------------------------)
X-Scan-Signature: 8df4a7bfcdb2e212470c7ae8a7e34bf5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
 
Hello,
~    I'm posting to the list blindly this following report:

LIST_DELETE: net/ipv4/netfilter/ip_conntrack_core.c:295
&ct->tuplehash[IP_CT_DIR_REPLY] (c40bf384) not in &ip_conntrack_hash[hr]

I believe the memory addresses are not as pertinent as the message
itself, but the screen filled up with 4-5 of these lines before finally
biting the dust.

Can someone shoot me an e-mail in reply to let me know if this is a bug
in netfilter code or if I'm just somehow confusing the heck out of the
nat filter?  I've got a set of nat forwarding rules that forwards an ip
address onto the internal lan, and then from there I'm only allowing
certain packets to go through -- that seems to have exacerbated the
problem..

Thanks in advance!

Pete

- --
- ---
/------------------------------------------------\
|Peter Grace                  Phone: 484-875-9462
|Technology Analyst             Fax: 484-875-9461
|RealTime Technologies, Inc.   Cell: 484-919-1400
|835 Springdale Drive, Suite 101
|Exton, PA  19341
\------------------------------------------------/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
 
iD8DBQFAMNrc1bytwQSw7hoRAlAdAKDRNDHBduc9hohuYZDiq05u3HFsLACgzFUA
Vkee3U/KD1+wrWRWBohbWCM=
=j2ZU
-----END PGP SIGNATURE-----


