Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTJOVAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 17:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbTJOVAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 17:00:53 -0400
Received: from 12-235-58-121.client.attbi.com ([12.235.58.121]:20236 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264328AbTJOVAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 17:00:52 -0400
Date: Wed, 15 Oct 2003 14:00:09 -0700
From: Christopher Li <lkml@chrisli.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Josh Litherland <josh@temp123.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031015210009.GB1739@64m.dyndns.org>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8D6417.8050409@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 11:13:27AM -0400, Jeff Garzik wrote:
> Josh and others should take a look at Plan9's venti file storage method 
> -- archival storage is a series of unordered blocks, all of which are 
> indexed by the sha1 hash of their contents.  This magically coalesces 

That is cool. I can image it will help versioning file system.
I guess it still need to compare the whole block for possible hash collision.
I should check it out.

Chris
