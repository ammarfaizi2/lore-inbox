Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271233AbTGWTZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271235AbTGWTYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:24:07 -0400
Received: from postman1.arcor-online.net ([151.189.0.187]:59009 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S271233AbTGWTV6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:21:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: softpro@gmx.net
Reply-To: ahljoh@uni.de
To: linux-kernel@vger.kernel.org
Subject: directory inclusion in ext2/ext3
Date: Wed, 23 Jul 2003 21:36:44 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030723193645.99E3C371@mendocino>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i have been looking for the possibility to display the contents of several 
directories in another one, but have so far not found anything suitable.

the two possibilites i considered so far were:

- soft-linking all files one by one, but then changes in a linked file 
(renaming, moving, deleting, ...) won't be noticed by the soft-links.
- LVM: exactly what i want as functionality but too low-level. i don't need 
any device merging, striping, mirroring, but just want to be able to link 
directory-contents.

i think it shouldn't be so hard to implement something similar to 
softlinks in ext2 that allows directories to have something like an 
include-directive to display contents of other directories as well.

hope this ain't too naive :-))

Johannes
