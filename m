Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756869AbWKVAVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869AbWKVAVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 19:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756886AbWKVAVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 19:21:49 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:17610 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1756869AbWKVAVs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 19:21:48 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: James Hunt <james@jameshunt.org.uk>
Subject: Re: [PATCH 1/3] ext2/3/4: enable "undeletable" file attribute.
Date: Wed, 22 Nov 2006 01:21:32 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sct@redhat.com
References: <20061121221632.GA12422@localdomain>
In-Reply-To: <20061121221632.GA12422@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611220121.33522.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 23:16, James Hunt wrote:
> ... it's not honoured by the kernel:
> 
>   > rm /tmp/wibble             # yikes! this should fail!!
> 
I always thought of the term 'undeletable' to mean that you can undelete
the file (restore it) after it has been deleted. Of course, this is
not implemented either, but it means something very different than
what your patch does.

	Arnd <><
