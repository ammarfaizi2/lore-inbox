Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130887AbRALAJK>; Thu, 11 Jan 2001 19:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132904AbRALAIp>; Thu, 11 Jan 2001 19:08:45 -0500
Received: from frontier.axistangent.net ([63.101.14.200]:47099 "EHLO
	foozle.turbogeek.org") by vger.kernel.org with ESMTP
	id <S129631AbRALAIi>; Thu, 11 Jan 2001 19:08:38 -0500
Date: Thu, 11 Jan 2001 18:08:35 -0600
From: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
To: linux-kernel@vger.kernel.org, ftpadmin@kernel.org
Subject: kernel.org signer broken?
Message-ID: <20010111180835.A19198@foozle.turbogeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The signature on man-pages-1.34.tar.gz is bad:

  gpg: Signature made Sun Dec 24 10:56:01 2000 CST using DSA key ID
       517D0F0E
  gpg: BAD signature from "Linux Kernel Archives Verification Key
       <ftpadmin@kernel.org>"

I retrieved the man pages from ftp.kernel.org and ftp.us.kernel.org
with ftp(1) from NetKit and lftp. The md5sum's of all match:

13d544485d6021e3b0585ad963bfd814  man-pages-1.34.tar.gz
29f314640ef28a47f0ed15247c1efcd7  man-pages-1.34.tar.gz.sign

(transfered the .sign file in both bin and ascii modes, no differance)

Everything else I've gotten recently has had a valid signature;
linux-2.4.0.tar.gz and patch-2.4.1-pre1.gz.

Since man pages can be used as trojans, this may be a problem.

-- 
Jeremy M. Dolan <jmd@turbogeek.org>
OpenPGP key = http://turbogeek.org/openpgp-key
OpenPGP fingerprint = 494C 7A6E 19FB 026A 1F52  E0D5 5C5D 6228 DC43 3DEE
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
