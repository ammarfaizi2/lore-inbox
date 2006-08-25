Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWHYLCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWHYLCI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 07:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWHYLCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 07:02:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38316 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964879AbWHYLCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 07:02:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200608251217.24543.arnd@arndb.de> 
References: <200608251217.24543.arnd@arndb.de>  <200608250023.13204.arnd@arndb.de> <20060824213316.21323.54434.stgit@warthog.cambridge.redhat.com> <15287.1156498053@warthog.cambridge.redhat.com> 
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] BLOCK: Move the loop device ioctl compat stuff to the loop driver [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 12:01:56 +0100
Message-ID: <13649.1156503716@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> My idea was to do the copy_from_user in loop_set_status_compat instead
> of loop_info64_from_compat, but your solution should be completely
> equivalent.

This way will have used less stack when it gets to the main part of the loop
driver.

David
