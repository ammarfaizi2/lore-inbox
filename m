Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTDGNt4 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbTDGNt4 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:49:56 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:9669 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S263436AbTDGNty convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 09:49:54 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Interactivity backport to 2.4.20-ck*
Date: Mon, 7 Apr 2003 23:53:38 +1000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304072353.47664.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've had numerous requests for a backport of the interactivity changes to the 
O(1) scheduler for the -ck* kernels. I have resisted posting my backport 
because people had described real problems with these patches. However it 
seems most, if not all of the problems are related to one patch. 

I've posted a special split out patch 
(001_o1_int_pe_ll_030407_ck_2.4.20.patch) for ck that includes the new 
interactivity changes, with the one patch responsible for problems backed 
out. No desktop tuning patch is supposed to be necessary for this so I've 
removed it from the site.Note that the full -ck4 patch does not include this 
update. I would like some feedback from people using it before I make a more 
substantial update to bring out a -ck5. The patches must be applied manually 
in order as they're desired. I've been using them for a little while without 
any problems. 

Get them here:

http://kernel.kolivas.org

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+kYLlF6dfvkL3i1gRAk4+AKClVUe0bhxJKSM5rls1zEfNE9TymQCglChA
xheK/JrNmZUnpm14LhgKMeQ=
=/Vun
-----END PGP SIGNATURE-----

