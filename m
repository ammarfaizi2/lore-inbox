Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbWB1VOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbWB1VOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWB1VOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:14:04 -0500
Received: from ns2.suse.de ([195.135.220.15]:41670 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932620AbWB1VOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:14:01 -0500
From: Chris Mason <mason@suse.com>
To: Dave Johnson <djohnson@sw.starentnetworks.com>
Subject: Re: cramfs mounts provide corrupted content since 2.6.15
Date: Tue, 28 Feb 2006 16:13:56 -0500
User-Agent: KMail/1.9.1
Cc: agruen@suse.de, Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
References: <20060225110844.GA18221@suse.de> <200602281553.01094.mason@suse.com> <17412.48069.779583.804584@zeus.sw.starentnetworks.com>
In-Reply-To: <17412.48069.779583.804584@zeus.sw.starentnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602281613.57945.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 16:08, Dave Johnson wrote:

> Ah, that makes sense now.
>
> parse_directory() is different between util-linux 2.12r and
> cramfstools 1.1:

Great, I knew this was a userland bug as well, but since we've clearly got 
broken cramfs images out there, I think it makes sense to add the fix in the 
kernel too.

-chris
