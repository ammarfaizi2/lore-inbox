Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423121AbWJRWtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423121AbWJRWtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423123AbWJRWtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:49:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:51455 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1423121AbWJRWtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:49:05 -0400
Date: Thu, 19 Oct 2006 00:45:21 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       kronos.it@gmail.com, ismail@pardus.org.tr, 7eggert@gmx.de
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
In-Reply-To: <453644f3.0BzwxliMKAw+rSMj%Joerg.Schilling@fokus.fraunhofer.de>
Message-ID: <Pine.LNX.4.58.0610182023100.2145@be1.lrz>
References: <771eN-VK-9@gated-at.bofh.it> <771yn-1XU-65@gated-at.bofh.it>
 <E1GZy4L-00015O-AV@be1.lrz> <453644f3.0BzwxliMKAw+rSMj%Joerg.Schilling@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Joerg Schilling wrote:
> Bodo Eggert <7eggert@elstempel.de> wrote:

> > BTW2, Just to be cautionous: what will happen if somebody forces the same
> > inode number on two different entries?

[...]
> This is something you cannot check.

Exactly that's why I'd ignore the on-disk "inode number" and instead use
the generated one untill someone comes along with a clever idea to fix
the issue or can show that it's mostly hermless.

-- 
Artificial Intelligence usually beats real stupidity. 
