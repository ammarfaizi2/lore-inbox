Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTGBJx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 05:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264897AbTGBJxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 05:53:00 -0400
Received: from gate.firmix.at ([80.109.18.208]:47758 "EHLO tara.firmix.at")
	by vger.kernel.org with ESMTP id S264916AbTGBJuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 05:50:54 -0400
Subject: Re: build from RO source tree?
From: Bernd Petrovitsch <bernd@firmix.at>
To: david nicol <whatever@davidnicol.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1057139553.5088.20.camel@plaza.davidnicol.com>
References: <1057139553.5088.20.camel@plaza.davidnicol.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057140312.4445.80.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 02 Jul 2003 12:05:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mit, 2003-07-02 at 11:52, david nicol wrote:
> Is there a make option for building from a read-only kernel source,
> possibly by doing a pre-pass to create a mess of symlinks?
> 
> Something like
> 
> 	(chdir $readonly_sourceroot && find . -type d ) \
> 	| xargs -n5 mkdir
> 	(chdir $readonly_sourceroot && find . -type f ) \
> 	| xargs -i ln -s $readonly_sourceroot/{} {}
> 	make
> 
> 
> but as a configure option of some kind.

man lndir

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
        Embedded Linux Development and Services
