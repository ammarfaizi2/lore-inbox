Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263404AbTJBREh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 13:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTJBREg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 13:04:36 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:32182 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263404AbTJBREe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 13:04:34 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16252.23200.511369.466054@laputa.namesys.com>
Date: Thu, 2 Oct 2003 21:04:32 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: 2.6.0-test6-mm2
In-Reply-To: <20031002022341.797361bc.akpm@osdl.org>
References: <20031002022341.797361bc.akpm@osdl.org>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm2/
 > 
 > . A large series of VFS patches from Al Viro which replace usage of
 >   file->f_dentry->d_inode->i_mapping with the new file->f_mapping.
 > 
 >   This is mainly so we can get disk hot removal right.

What consequences does this have for (out-of-the-tree) file systems,
beyond s/->f_dentry->d_inode->i_mapping/->f_mapping/g ?

 > 

Nikita.
