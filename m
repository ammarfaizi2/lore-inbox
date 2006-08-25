Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWHYIim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWHYIim (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 04:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWHYIim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 04:38:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59845 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932236AbWHYIil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 04:38:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200608250023.20903.arnd@arndb.de> 
References: <200608250023.20903.arnd@arndb.de>  <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213318.21323.12558.stgit@warthog.cambridge.redhat.com> 
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] BLOCK: Move common FS-specific ioctls to linux/fs.h [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 09:38:37 +0100
Message-ID: <1925.1156495117@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> 	case FS_IOC_GETFLAGS32:
> 	case FS_IOC_GETFLAGS64:

That'll get you a "duplicate case statement" warning on a 32-bit arch.

David
