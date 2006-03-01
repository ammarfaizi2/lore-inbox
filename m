Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWCAM2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWCAM2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 07:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWCAM2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 07:28:30 -0500
Received: from viking.sophos.com ([194.203.134.132]:38416 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S1030203AbWCAM23
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 07:28:29 -0500
In-Reply-To: <1141202744.11585.20.camel@lade.trondhjem.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] vfs: cleanup of permission()
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.5.2 June 01, 2004
Message-ID: <OFAFEC22B7.7F7518A9-ON80257124.0043AF58-80257124.00448503@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Wed, 1 Mar 2006 12:28:25 +0000
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 6.5.2|June
 01, 2004) at 01/03/2006 12:28:24,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 6.5.2|June
 01, 2004) at 01/03/2006 12:28:24,
	Serialize complete at 01/03/2006 12:28:24,
	S/MIME Sign failed at 01/03/2006 12:28:24: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.5|November 30, 2005) at
 01/03/2006 12:28:26,
	Serialize complete at 01/03/2006 12:28:26
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2006-02-28 at 06:26 +0100, Herbert Poetzl wrote:
> Hi Andrew! Christoph! Al!
> 
> after thinking some time about the oracle words
> (sent in reply to previous BME submissions) we 
> (Sam and I) came to the conclusion that it would 
> be a good idea to remove the nameidata introduced
> in September 2003 from the inode permission()
> checks, so that vfs_permission() can take care
> of them ...

Could you please provide a link to that 'previous BME submissions'? 
Thanks.

Also, since you are modifying LSM interfaces, why not discuss it on the 
LSM mailing list?

And finally, please don't remove nameidata. Modules out there depend on it 
and we at Sophos are about to release a new product which needs it as 
well. The plan was to announce the whole thing parallel with the release, 
but after spotting your post I was prompted to react ahead of the 
schedule. However, I am very busy at the moment so the actual announcment 
with full details will have to wait for a week or two.

