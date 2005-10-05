Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbVJEQQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbVJEQQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVJEQQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:16:39 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:25246 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030212AbVJEQQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:16:38 -0400
Date: Wed, 5 Oct 2005 18:16:33 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Marc Perkel <marc@perkel.com>
cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Nix <nix@esperi.org.uk>,
       7eggert@gmx.de, Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <4343E7AC.6000607@perkel.com>
Message-ID: <Pine.LNX.4.58.0510051801530.2279@be1.lrz>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
 <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
 <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca>
 <4343E7AC.6000607@perkel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, Marc Perkel wrote:

> What is incredibly idiotic is a file system that allws you to delete 
> files that you have no write access to. That is stupid beyond belief and 
> only the Unix community doesn't get it.

1) Unlinking is not deleting, it may just trigger deleting. !Unix people 
   don't get it.

   If you like non-owners to have no unlink permission, you have to set 
   the sticky bit. If you want other users not to be able to delete files
   you put into a public directory, put a link into that directory and 
   keep one in a private directory.

2) If you're accounted for the space occupied by your directories, you 
   need the permission to remove the directory. Otherwise you could DoS 
   other users if you have write permission in one of his directories.

-- 
Funny quotes:
29. When someone asks you, "A penny for your thoughts" and you put your two
    cents in . . . what happens to the other penny?
