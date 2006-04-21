Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWDUOeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWDUOeV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWDUOeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:34:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:20011 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932337AbWDUOeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:34:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=aJALnoU1aPx4Vq0aIL5YfZWZzIxpml/HgDPFv8gyOjqvagm4dVl7Cle8VOsKyBTv4ox0lGDFrRPLhQkulbdZestiI8sXYBY1rIiROHs/MOIyDMZv0R+4fCYpzcD3AY0aFUfz9Y5X8Hd/kFrNm7Sa4NM2Zu8t7WpukuFdreB3lBU=
Message-ID: <4448EEE7.5010708@gmail.com>
Date: Fri, 21 Apr 2006 21:40:39 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5.0.2 (X11/20060308)
MIME-Version: 1.0
To: Hua Zhong <hzhong@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rename "swapper" to "idle"
References: <000301c66503$3bbd8060$0200a8c0@nuitysystems.com>
In-Reply-To: <000301c66503$3bbd8060$0200a8c0@nuitysystems.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hua Zhong wrote:
> Swapper does not do these things. It just happens to be "running" at that time (and it is always running if the system is idle).
> 
> IOW, it is indeed an "idle" process. In fact, all it does is cpu_idle().

Really? Are your sure that swapper only does cpu_idle()???
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESO7nNWc9T2Wr2JcRAkRlAJwIJumKnS0tj1BvhYZPfoChR7fSAwCdEcC9
TFKn1OA9Wv448TqFU1bxk5k=
=eGf2
-----END PGP SIGNATURE-----
