Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293335AbSB1PVx>; Thu, 28 Feb 2002 10:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293140AbSB1PTU>; Thu, 28 Feb 2002 10:19:20 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4127 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S293409AbSB1PSI>; Thu, 28 Feb 2002 10:18:08 -0500
Date: Thu, 28 Feb 2002 10:18:00 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.org
Subject: Re: thread groups bug?
Message-ID: <20020228101800.F8011@redhat.com>
In-Reply-To: <2628.1014907956@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2628.1014907956@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Thu, Feb 28, 2002 at 02:52:36PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 02:52:36PM +0000, David Howells wrote:
> 
> If the master thread of a thread group (PID==TGID) performs an execve() then
> it is possible to end up with two or more thread groups with the same TGID.

How about: (3) make execve allocate a new thread group id?

		-ben
