Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVJCQEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVJCQEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVJCQEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:04:34 -0400
Received: from hulk.vianw.pt ([195.22.31.43]:38875 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S932321AbVJCQEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:04:33 -0400
Message-ID: <4341567E.4050603@esoterica.pt>
Date: Mon, 03 Oct 2005 17:04:14 +0100
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: util-linux and data encryption
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this is not the right place to post about
util-linux, please tell me where to post.
I'm posting here because util-linux is at kernel.org.
_____________________________
I had a loop filesystem encrypted with twofish
algorithm.

Today, trying to mount the file, 'mount' claimed
I needed to enter a password of 20 chars or more!
Since I used less chars to encrypt, I was not able
to recover the information!!!
I tried CFLAGS="-DLOOP_PASSWORD_MIN_LENGTH=8"
without any success. This causes 'mount' to accept
the password, but, somehow, the decryption failled
because the fs type remained unrecognized!

BTW, I am using gentoo and I also tried USE=old-crypt.
No way!

I needed to install the version 2.12i to recover
my information.

Is this related with util-linux or has something
to do with gentoo patches or something?

This should not happen! Changing things like this
must keep some kind of compatibility with old ones.

How do I encrypt important data for the future?

Thank you for any comments.

