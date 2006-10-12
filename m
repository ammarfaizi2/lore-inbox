Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161352AbWJLCZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161352AbWJLCZC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 22:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965260AbWJLCY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 22:24:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56806 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965259AbWJLCY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 22:24:58 -0400
Date: Wed, 11 Oct 2006 22:24:54 -0400
From: Dave Jones <davej@redhat.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] m68k: more workarounds for recent binutils idiocy
Message-ID: <20061012022454.GA19232@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Al Viro <viro@ftp.linux.org.uk>, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
References: <E1GXlNt-0004Xc-Fi@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GXlNt-0004Xc-Fi@ZenIV.linux.org.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 10:13:01PM +0100, Al Viro wrote:

 > +.macro  putuser_inc src,dest,label
 > +        getuser.l \src,"(\dest)+",\label,\dest
 > +.endm

Bad cut-n-paste ?

	Dave

-- 
http://www.codemonkey.org.uk
