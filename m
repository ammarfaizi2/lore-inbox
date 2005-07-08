Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVGHKc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVGHKc1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVGHK36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:29:58 -0400
Received: from gw.alcove.fr ([81.80.245.157]:14756 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S262471AbVGHK2z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:28:55 -0400
Subject: Re: GIT tree broken?
From: Stelian Pop <stelian@popies.net>
To: Andrew Morton <akpm@osdl.org>
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org
In-Reply-To: <20050708031857.5b1d5950.akpm@osdl.org>
References: <Pine.SOC.4.61.0507081227540.25021@math.ut.ee>
	 <1120816858.4688.4.camel@localhost.localdomain>
	 <20050708031857.5b1d5950.akpm@osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Fri, 08 Jul 2005 12:27:28 +0200
Message-Id: <1120818448.4684.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 08 juillet 2005 à 03:18 -0700, Andrew Morton a écrit :

> Maybe post-0.12 broke.  Try the 0.12 release.

Did try that but it does not solve the problem:

deep-space-9:~/kernel/git 41 > cg-version
cogito-0.12
deep-space-9:~/kernel/git 42 > cg-clone
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
linux-2.6.git
defaulting to local storage area
12:26:25
URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/heads/master [41/41] -> "refs/heads/origin" [1]
progress: 2 objects, 981 bytes
error: File 2a7e338ec2fc6aac461a11fe8049799e65639166
(http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/2a/7e338ec2fc6aac461a11fe8049799e65639166) corrupt

Cannot obtain needed blob 2a7e338ec2fc6aac461a11fe8049799e65639166
while processing commit 0000000000000000000000000000000000000000.
cg-pull: objects pull failed
cg-init: pull failed


If I manually try to get
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/2a/7e338ec2fc6aac461a11fe8049799e65639166 I get a 404 in return.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

