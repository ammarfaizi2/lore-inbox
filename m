Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVACXgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVACXgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVACXgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:36:25 -0500
Received: from mail1.edisontel.com ([62.94.0.30]:8648 "EHLO ims1.edisontel.com")
	by vger.kernel.org with ESMTP id S261975AbVACXdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:33:33 -0500
Message-ID: <41D9D45F.7030506@gmail.com>
Date: Tue, 04 Jan 2005 00:25:19 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] A different implementation of LSM?
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

One of the biggest limitations of LSM is we can't implement more than
one handler for each security hook at the same time.
Is it advisable to revise the actual implementation, introducing a
doubly linked list based mechanism (such as Netfilter implementation),
or this is the best solution in order to limit overhead?

Regards,


					Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQdnUXxZrwl7j21nOAQLjxggAqSj6dxqxuj2Gk2mcS8WzcPiU2bOWkzdw
daHSXLRiITeSkGTGYy6agV7L32hG/YyxiB1sb+rezcPuPq/Xu/78Nzn4kY076c52
DATYTvBPQnlJI3BO0MrCTFoZ+l0PLGuwKnm7cZbttTlLHyUfyPpke2T28UrSsqcR
K0R76nihN9BGnPf1vF0YggvqJlBmXDJj1sPmOs16KadXKpIbXG5PCYoqHeW6dwlH
5fRU4VlK05vHir3tyKcfAfhUjY45YntV7rV2lD0id2Wn0Vumb/SDyxgQnR/3sSjl
10TI4NbHIBsMiA7isT+5HKASyG1ZMoZyVeQlmvFRMZlqa0t/U7H9QQ==
=lC1A
-----END PGP SIGNATURE-----

