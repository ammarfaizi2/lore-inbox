Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263160AbVFXSsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbVFXSsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 14:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbVFXSsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 14:48:05 -0400
Received: from main.gmane.org ([80.91.229.2]:15785 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263160AbVFXSru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 14:47:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Hubert Chan <hubert@uhoreg.ca>
Subject: Re: reiser4 plugins
Date: Fri, 24 Jun 2005 14:42:54 -0400
Message-ID: <874qbnh9zl.fsf@evinrude.uhoreg.ca>
References: <ninja@slaphack.com> <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe0004e289e618-cm000f212c9dfc.cpe.net.cable.rogers.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:vOnRAann/ZpASWAu6lCbq3z2tUQ=
Cc: reiserfs-list@namesys.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005 22:41:01 -0400, Horst von Brand <vonbrand@inf.utfsm.cl> said:

> David Masover <ninja@slaphack.com> wrote:
>> I, for one, would like to use a pendrive and have certain files be
>> encrypted transparently, only for use on Linux, but others be ready
>> to transfer to a Windows box.

> And that would surely break Windows compatibility (because you have to
> keep the data on what to encrypt one the filesystem itself).

Easily solved, using the same method OS/2 added Extended Attribute
support to FAT.  Of course, things may break if you try to manipulate
the encrypted file under Windows (e.g. deleting those files would leave
some garbage blocks behind), but breakage should be minor and relatively
easy to fix.

> Besides, having pgp, or gpg, or crypt, or my own whacky encryption
> proggie do the job in /userland/, and not shoving into the kernel and
> so down the next user's throat, is in the end a largeish part of what
> Unix is all about for me.

Meh.  It's nice to have encrypting to be transparent.  Unless your
editor supports gpg/crypt/etc., you'll need to decrypt the file to a
temporary area, edit the file, and then re-encrypt.  Much easier to make
a mistake and lose data, or leave traces of the cleartext data.

Besides, the encryption would be optional, and hence not being shoved
down the user's throat.  If you don't like it, don't use it.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

