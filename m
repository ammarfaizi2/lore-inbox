Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbTEMPvO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTEMPvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:51:13 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:64264 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261780AbTEMPue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:50:34 -0400
Date: Tue, 13 May 2003 17:03:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support
Message-ID: <20030513170317.A29503@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	openafs-devel@openafs.org
References: <8624.1052840360@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8624.1052840360@warthog.warthog>; from dhowells@redhat.com on Tue, May 13, 2003 at 04:39:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 04:39:20PM +0100, David Howells wrote:
>  (3) AFS multiplexor support. Not complete at the moment, but implemented far
>      enough to provide access to the PAG mechanism. Further patches will be
>      forthcoming to make this fully functional.

This is broken.  Please add individual syscalls instead of yet another broken
multiplexer.

and do you really think this is a 2.6 thing?

