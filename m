Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVCVTJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVCVTJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVCVTJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:09:33 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:11395 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261660AbVCVTJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:09:31 -0500
Date: Tue, 22 Mar 2005 20:09:32 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.12-rc1-mm1: REISER4_FS <-> 4KSTACKS
Message-ID: <20050322190932.GC27733@wohnheim.fh-wedel.de>
References: <20050321025159.1cabd62e.akpm@osdl.org> <20050322171340.GE1948@stusta.de> <20050322185605.GB27733@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050322185605.GB27733@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 March 2005 19:56:05 +0100, Jörn Engel wrote:
> 
> stackframes for call path too long (2808):

Maybe I should change the output.  "too long" simply means "user gave
a stack limit below this value".  2808 bytes is the most expensive
path for reiser4 without recursion, so my limit was 2800. ;)

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein
