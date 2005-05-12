Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVELMS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVELMS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVELMS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:18:57 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:54216 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261575AbVELMSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:18:41 -0400
Date: Thu, 12 May 2005 14:18:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
Message-ID: <20050512121842.GA20388@wohnheim.fh-wedel.de>
References: <20050509183135.GB27743@mary>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050509183135.GB27743@mary>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005 20:40:22 +0200, Markus Klotzbuecher wrote:
> 
> mini_fo is a virtual kernel filesystem that can make read-only file
> systems writable. This is done by redirecting modifying operations to
> a writeable location called "storage directory", and leaving the
> original data in the "base directory" untouched. When reading, the
> file system merges the modifed and original data so that only the
> newest versions will appear. This occurs transparently to the user,
> who can access the data like on any other read-write file system.
> 
> mini_fo was originally developed for use in embedded systems, and
> therefore is lightweight in terms of module size (~50K), memory usage
> and storage usage. Nevertheless it has proved usefull for other
> projects such as live cds or for sandboxing and testing.

Just out of curiosity: how do you perform the copy-up operation?
In-kernel copies of large files are a huge problem and for union-mount
purposes, I'm clueless about how to fix things.

Jörn

-- 
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague. 
-- Edsger W. Dijkstra
