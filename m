Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263297AbUJ2MBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263297AbUJ2MBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 08:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbUJ2MAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 08:00:16 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:45828 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263290AbUJ2L7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:59:04 -0400
Date: Fri, 29 Oct 2004 12:59:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: Re: New kbuild filename: Kbuild
Message-ID: <20041029115903.GC11391@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org> <20041028190020.GB9004@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028190020.GB9004@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 09:00:20PM +0200, Sam Ravnborg wrote:
> kbuild: Prefer Kbuild as name of the kbuild files
>    
> The kbuild syntax is unique and does only have very few things in common with
> usual Makefile syntax. So to avoid confusion make the filename 'Kbuild' be
> the preferred name as replacement for 'Makefile'.
> No global renaming planned to take place for now, but new stuff expected to use
> the new 'Kbuild' filename.

Disagree.  These are just makefiles, and renaming for the sake of it
doesn't buy us.  If you really want to improve things implement something like

 module foo.ko
 sources foo.c blah.c
 sources foobar.c if FOO_BAR

in Kconfig and get rid of driver makefiles compeltely

