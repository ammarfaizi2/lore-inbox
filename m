Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTLCVsQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTLCVsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:48:11 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:65438 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262153AbTLCVsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:48:05 -0500
Date: Wed, 3 Dec 2003 22:44:43 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Kallol Biswas <kbiswas@neoscale.com>
Cc: linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
Message-ID: <20031203214443.GA23693@wohnheim.fh-wedel.de>
References: <1070485676.4855.16.camel@nucleon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1070485676.4855.16.camel@nucleon>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 December 2003 13:07:56 -0800, Kallol Biswas wrote:
> 
> Hello,
>       We have a requirement that a filesystem has to support
> encryption based on some policy. The filesystem also should be able 
> to store data in non-encrypted form. A search on web shows a few 
> encrypted filesystems like "Crypto" from Suse Linux, but we need a
> system  where encryption will be a choice per file. We have a hardware
> controller to apply encryption algorithm. If a filesystem provides hooks
> to use a hardware controller to do the encryption work then the cpu can
> be freed from doing the extra work.
> 
> Any comment on this?

Haven't heard about anything working yet, but it shouldn't be too hard
to change something existing.  For jffs2, I would guesstimate one or
two month to add the necessary bits, but jffs2 is not first choice as
a hard drive filesystem.  Not sure about other filesystems.

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
