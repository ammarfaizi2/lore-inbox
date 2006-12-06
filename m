Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760571AbWLFMsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760571AbWLFMsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760570AbWLFMsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:48:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36246 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760567AbWLFMsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:48:39 -0500
Subject: Re: Relative atime (was Re: What's in ocfs2.git)
From: Arjan van de Ven <arjan@infradead.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, Valerie Henson <val_henson@linux.intel.com>,
       mark.fasheh@oracle.com, steve@chygwyn.com, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk
In-Reply-To: <200612061042.58595.dada1@cosmosbay.com>
References: <20061203203149.GC19617@ca-server1.us.oracle.com>
	 <20061205003619.GC8482@goober> <20061205205802.92b91ce1.akpm@osdl.org>
	 <200612061042.58595.dada1@cosmosbay.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 06 Dec 2006 13:48:21 +0100
Message-Id: <1165409301.3233.443.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> > 	if (inode->i_sb->s_flags & MS_NOATIME)
> > 		return;
> So that that one can be deleted.


Hi,

I would mostly expect the compiler to be relatively smart about this and
group a bunch of these tests together... so I rather see readable code
than optimized code for something the compiler should be doing for us ;)

Greetings,
   Arjan van de Ven

