Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbTEOQsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 12:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTEOQqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 12:46:01 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:232 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S264114AbTEOQpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 12:45:03 -0400
Date: Thu, 15 May 2003 13:18:25 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] PAG support, try #2
Message-ID: <20030515131825.G672@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44.0305140924040.3107-100000@home.transmeta.com> <19800.1052933820@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <19800.1052933820@warthog.warthog>; from dhowells@warthog.cambridge.redhat.com on Wed, May 14, 2003 at 06:37:00PM +0100
X-Spam-Score: -4.2 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19GM3F-0006BK-00*dr9HJgwGFdY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 06:37:00PM +0100, David Howells wrote:
> And then you have to have some method of prioritisation. You may find that
> user dhowells has a token for (fs=AFS,cell=redhat.com) and group engineering
> has a token for (fs=AFS,cell=redhat.com). Which do you use?

Union of both. And remember to subtract negative ACLs from
positive ACLs. Prioritize users over groups in case of explicit
mention.

This is standard permission checking.

Hmm, sounds too simple, so it must be wrong ;-)

Regards

Ingo Oeser
