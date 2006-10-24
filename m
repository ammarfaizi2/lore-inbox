Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWJXJdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWJXJdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 05:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWJXJdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 05:33:11 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:34971 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965123AbWJXJdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 05:33:09 -0400
Date: Tue, 24 Oct 2006 11:32:49 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-fsdevel@vger.kernel.org, Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, swhiteho@redhat.com, bjornw@axis.com,
       reiserfs-dev@namesys.com, chris.mason@oracle.com
Subject: Re: [RFC] commit_write less than prepared by prepare_write
Message-ID: <20061024093249.GA22279@wohnheim.fh-wedel.de>
References: <20061022084020.GA23506@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061022084020.GA23506@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 October 2006 10:40:20 +0200, Nick Piggin wrote:
> 
> Filesystems that are non trivial are GFS2, OCFS2, Reiserfs, JFFS so
> I need maintainers to look at those.

JFFS has been unmaintained for some years and barely evaded removal at
least once.  Now might be the time to pull support for good or else
convert it by adding an #error to it.

Jörn

-- 
This above all: to thine own self be true.
-- Shakespeare
