Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbUATSIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbUATSIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:08:20 -0500
Received: from spf13.us4.outblaze.com ([205.158.62.67]:45000 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S265622AbUATSIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:08:15 -0500
Message-ID: <20040120180646.7874.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 20 Jan 2004 13:06:46 -0500
Subject: Re: [OT] Redundancy eliminating file systems, breaking MD5,
    donating money to OSDL
X-Originating-Ip: 172.192.146.33
X-Originating-Server: ws3-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(re: md5 weakness)

The only document I've seen with a
rigorous demonstration of the
possibility of an md5 collision
created it by adding 0 (zero) bytes
to an input (so the colliding inputs
were not the same size in bytes).

Good luck finding a collision with
blocks that are all the same size.

Anyway, hash matching algorithms for
variable sized inputs (hashed extents,
etc) can probably get an additional several
orders of magnitude of safety by using
two hashes (md5 and sha1, for example).

What are the chances that the same two
different inputs that hash to the same
value using one of them collides in the
other, too? ("Left as an exercise for the ...")

Regards,

Clayton Weaver
<mailto: cgweav@email.com>

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

